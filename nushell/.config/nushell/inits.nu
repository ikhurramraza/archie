# Default programs
$env.BROWSER = "firefox"
$env.EDITOR = "nvim"
$env.TERMINAL = "wezterm"

# LS_COLORS like we love
$env.LS_COLORS = "rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:"

# Set language to English
$env.LANG = "en_US.UTF-8"

# XDG Dirs
$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
$env.XDG_CACHE_HOME = $"($env.HOME)/.cache"
$env.XDG_DATA_HOME = $"($env.HOME)/.local/share"
$env.XDG_STATE_HOME = $"($env.HOME)/.local/state"

# Set environment variables for XDG compliant paths
$env.BUNDLE_USER_CACHE = $"($env.XDG_CACHE_HOME)/bundle"
$env.BUNDLE_USER_CONFIG = $"($env.XDG_CONFIG_HOME)/bundle/config"
$env.BUNDLE_USER_PLUGIN = $"($env.XDG_DATA_HOME)/bundle"
$env.CARGO_HOME = $"($env.XDG_DATA_HOME)/cargo"
$env.DOCKER_CONFIG = $"($env.XDG_CONFIG_HOME)/docker"
$env.GNUPGHOME = $"($env.XDG_DATA_HOME)/gnupg"
$env.GOPATH = $"($env.XDG_DATA_HOME)/go"
$env.LESSHISTFILE = $"($env.XDG_STATE_HOME)/less/history"
$env.RUSTUP_HOME = $"($env.XDG_DATA_HOME)/rustup"
$env.ZDOTDIR = $"($env.XDG_CONFIG_HOME)/zsh"
$env._Z_DATA = $"($env.XDG_DATA_HOME)/z"

# Configure Pipenv
$env.PIPENV_VERBOSITY = "-1"
$env.PIPENV_VENV_IN_PROJECT = "enabled"
$env.VIRTUAL_ENV_DISABLE_PROMPT = "1"

# Configure IRB
$env.IRBRC = $"($env.XDG_CONFIG_HOME)/irb/irbrc"

# Configure gemrc
$env.GEMRC = $"($env.XDG_CONFIG_HOME)/gems/gemrc"

# Configure SQLite
$env.SQLITE_HISTORY = $"($env.XDG_DATA_HOME)/sqlite/history"

# Configure pass
$env.PASSWORD_STORE_DIR = $"($env.XDG_DATA_HOME)/pass"

# Configure notie
$env.NOTIE_DIRECTORY = "/mnt/Notes"

# Utility function to add new path to PATH env variable if it doesn't already exist
def --env append-to-path [path] {
  let paths = $env.PATH | split row (char esep)
  if ($paths | where { |row| $row == $path } | length) > 0 { return }

  $env.PATH = ($paths | append $path | str join (char esep))
}

# Utility function to add new path to PATH env variable if it doesn't already exist
def --env prepend-to-path [path] {
  let paths = $env.PATH | split row (char esep)
  if ($paths | where { |row| $row == $path } | length) > 0 { return }

  $env.PATH = ($paths | prepend $path | str join (char esep))
}

# Add local scripts to PATH
append-to-path $"($env.HOME)/.local/scripts"

# Add cargo bin directory to PATH
append-to-path $"($env.CARGO_HOME)/bin"

# Add go bin directory to PATH
prepend-to-path $"($env.GOPATH)/bin"

source bundler.nu
source carapace.nu
source direnv.nu
source mise.nu
source starship.nu
source stream.nu
source zoxide.nu
source atuin.nu
