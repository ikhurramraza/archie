#!/usr/bin/env bash

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

FILE_PATH=""
IMAGE_CACHE_PATH=""
PREVIEW_HEIGHT=10
PREVIEW_IMAGE_ENABLED=0
PREVIEW_WIDTH=10
PREVIEW_X_COORD=0
PREVIEW_Y_COORD=0

## Syntax highlight settings
HIGHLIGHT_SIZE_MAX=262143 # 256KiB
HIGHLIGHT_TABWIDTH=${HIGHLIGHT_TABWIDTH:-8}
HIGHLIGHT_STYLE=${HIGHLIGHT_STYLE:-pablo}
HIGHLIGHT_OPTIONS="--replace-tabs=${HIGHLIGHT_TABWIDTH} --style=${HIGHLIGHT_STYLE} ${HIGHLIGHT_OPTIONS:-}"

while [ "$#" -gt 0 ]; do
  case "$1" in
  "--path")
    shift
    FILE_PATH="$1"
    ;;
  "--preview-width")
    shift
    PREVIEW_WIDTH="$1"
    ;;
  "--preview-height")
    shift
    PREVIEW_HEIGHT="$1"
    ;;
  "--x-coord")
    shift
    PREVIEW_X_COORD="$1"
    ;;
  "--y-coord")
    shift
    PREVIEW_Y_COORD="$1"
    ;;
  "--preview-images")
    shift
    PREVIEW_IMAGE_ENABLED="$1"
    ;;
  "--image-cache")
    shift
    IMAGE_CACHE_PATH="$1"
    ;;
  esac
  shift
done

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="$(printf "%s" "${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')"

handle_extension() {
  case "${FILE_EXTENSION_LOWER}" in
  ## Archive
  a | ace | alz | arc | arj | bz | bz2 | cab | cpio | deb | gz | jar | lha | lz | lzh | lzma | lzo | \
    rpm | rz | t7z | tar | tbz | tbz2 | tgz | tlz | txz | tZ | tzo | war | xpi | xz | Z | zip)
    atool --list -- "${FILE_PATH}" && exit 5
    bsdtar --list --file "${FILE_PATH}" && exit 5
    exit 1
    ;;
  rar)
    ## Avoid password prompt by providing empty password
    unrar lt -p- -- "${FILE_PATH}" && exit 5
    exit 1
    ;;
  7z)
    ## Avoid password prompt by providing empty password
    7z l -p -- "${FILE_PATH}" && exit 5
    exit 1
    ;;

  ## PDF
  pdf)
    ## Preview as text conversion
    pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - |
      fmt -w "${PREVIEW_WIDTH}" && exit 5
    mutool draw -F txt -i -- "${FILE_PATH}" 1-10 |
      fmt -w "${PREVIEW_WIDTH}" && exit 5
    exiftool "${FILE_PATH}" && exit 5
    exit 1
    ;;

  ## Torrent
  torrent)
    transmission-show -- "${FILE_PATH}" && exit 5
    exit 1
    ;;

  ## OpenDocument
  odt | ods | odp | sxw)
    ## Preview as text conversion
    odt2txt "${FILE_PATH}" && exit 5
    ## Preview as markdown conversion
    pandoc -s -t markdown -- "${FILE_PATH}" && exit 5
    exit 1
    ;;

  ## XLSX
  xlsx)
    ## Preview as csv conversion
    ## Uses: https://github.com/dilshod/xlsx2csv
    xlsx2csv -- "${FILE_PATH}" && exit 5
    exit 1
    ;;

  ## MD
  md)
    glow --style=dark "${FILE_PATH}" && exit 5
    exit 1
    ;;

  ## HTML
  htm | html | xhtml)
    ## Preview as text conversion
    w3m -dump "${FILE_PATH}" && exit 5
    lynx -dump -- "${FILE_PATH}" && exit 5
    elinks -dump "${FILE_PATH}" && exit 5
    pandoc -s -t markdown -- "${FILE_PATH}" && exit 5
    ;;

  ## JSON
  json)
    jq --color-output . "${FILE_PATH}" && exit 5
    python -m json.tool -- "${FILE_PATH}" && exit 5
    ;;

  ## Direct Stream Digital/Transfer (DSDIFF) and wavpack aren't detected
  ## by file(1).
  dff | dsf | wv | wvc)
    mediainfo "${FILE_PATH}" && exit 5
    exiftool "${FILE_PATH}" && exit 5
    ;; # Continue with next handler on failure
  esac
}

handle_mime() {
  local mimetype="$(file --dereference --brief --mime-type -- "${FILE_PATH}")"

  case "${mimetype}" in
  ## RTF and DOC
  text/rtf | *msword)
    ## Preview as text conversion
    ## note: catdoc does not always work for .doc files
    ## catdoc: http://www.wagner.pp.ru/~vitus/software/catdoc/
    catdoc -- "${FILE_PATH}" && exit 5
    exit 1
    ;;

  ## DOCX, ePub, FB2 (using markdown)
  ## You might want to remove "|epub" and/or "|fb2" below if you have
  ## uncommented other methods to preview those formats
  *wordprocessingml.document | */epub+zip | */x-fictionbook+xml)
    ## Preview as markdown conversion
    pandoc -s -t markdown -- "${FILE_PATH}" && exit 5
    exit 1
    ;;

  ## XLS
  *ms-excel)
    ## Preview as csv conversion
    ## xls2csv comes with catdoc:
    ##   http://www.wagner.pp.ru/~vitus/software/catdoc/
    xls2csv -- "${FILE_PATH}" && exit 5
    exit 1
    ;;

  ## Text
  text/* | */xml)
    ## Syntax highlight
    if [[ "$(stat --printf='%s' -- "${FILE_PATH}")" -gt "${HIGHLIGHT_SIZE_MAX}" ]]; then
      exit 2
    fi
    if [[ "$(tput colors)" -ge 256 ]]; then
      local pygmentize_format='terminal256'
      local highlight_format='xterm256'
    else
      local pygmentize_format='terminal'
      local highlight_format='ansi'
    fi
    # cat "${FILE_PATH}" && exit 5
    # highlight --out-format="ansi" --force "${FILE_PATH}" && exit 5
    # env HIGHLIGHT_OPTIONS="${HIGHLIGHT_OPTIONS}" highlight \
    #     --out-format="${highlight_format}" \
    #     --force -- "${FILE_PATH}" && exit 5
    bat --color=always --style="plain" -- "${FILE_PATH}" && exit 0
    exit 2
    ;;

  ## DjVu
  image/vnd.djvu)
    ## Preview as text conversion (requires djvulibre)
    djvutxt "${FILE_PATH}" | fmt -w "${PREVIEW_WIDTH}" && exit 5
    exiftool "${FILE_PATH}" && exit 5
    exit 1
    ;;

  image/png | image/jpeg)
    dimension=" Size $(exiftool "$FILE_PATH" | grep '^Image Size' | awk '{print $4}')"
    tags=$(tmsu_tag_list)
    echo "$dimension"
    echo "$tags"
    meta_file="$(get_preview_meta_file $FILE_PATH)"
    # let y_offset=2
    let y_offset=$(printf "${tags}" | sed -n '=' | wc -l)+2
    echo "y-offset $y_offset" >"$meta_file"
    exit 4
    ;;

  ## Image
  image/*)
    # cat "${FILE_PATH}" && exit 5
    ## Preview as text conversion
    # img2txt --gamma=0.6 --width="${PREVIEW_WIDTH}" -- "${FILE_PATH}" && exit 4
    exiftool "${FILE_PATH}" && exit 5
    exit 1
    ;;

  ## Video and audio
  # video/* | audio/*)
  audio/*)
    mediainfo "${FILE_PATH}" && exit 5
    exiftool "${FILE_PATH}" && exit 5
    exit 1
    ;;
  esac
}

handle_extension
handle_mime
