FIND := $(shell command -v gfind >/dev/null 2>&1 && echo gfind || echo find)

SCRIPTS_DIRECTORY = $$HOME/.local/scripts

.PHONY: preflight all clean directories clean-directories scripts clean-scripts mpvnet windows-terminal snapshot

preflight:
	@$(FIND) . -maxdepth 0 -printf "" 2>/dev/null || { \
		echo "error: GNU find required (with -printf support)." >&2; \
		echo "       on macOS: brew install findutils  (provides 'gfind')." >&2; \
		exit 1; \
	}

all: preflight directories scripts mpvnet windows-terminal

clean: preflight clean-directories clean-scripts


directories: clean-directories
	$(FIND) . -maxdepth 1 \
	       -mindepth 1 \
	       -type d \
	       -not -path '*/.*' \
	       -not -path "*/vendor" \
	       -not -path "*/mpvnet" \
	       -not -path "*/windows-terminal" \
	       -printf "%P\0" | \
	xargs -0 stow --verbose --target=$$HOME --ignore=scripts --restow

clean-directories:
	mkdir -p $$HOME
	$(FIND) . -maxdepth 1 \
	       -mindepth 1 \
	       -type d \
	       -not -path '*/.*' \
	       -not -path "*/vendor" \
	       -not -path "*/mpvnet" \
	       -not -path "*/windows-terminal" \
	       -printf "%P\0" | \
	xargs -0 stow --verbose --target=$$HOME --ignore=scripts --delete


scripts: clean-scripts
	mkdir -p ${SCRIPTS_DIRECTORY}
	$(FIND) $$PWD/*/.local/scripts/ -type f -exec ln -s "{}" ${SCRIPTS_DIRECTORY}/ \;

clean-scripts:
	mkdir -p ${SCRIPTS_DIRECTORY}
	$(FIND) $$PWD/*/.local/scripts -maxdepth 1 -type f -printf "%f\n" | \
	xargs -I{} sh -c 'unlink ${SCRIPTS_DIRECTORY}/{} || true'


mpvnet:
	@command -v wslpath >/dev/null 2>&1 || { echo "mpvnet: not WSL, skipping"; exit 0; }
	@dest="$$(wslpath "$$(cmd.exe /c 'echo %APPDATA%' 2>/dev/null | tr -d '\r')")/mpv.net"; \
	mkdir -p "$$dest"; \
	cp mpvnet/*.conf "$$dest/"; \
	if [ -d mpvnet/scripts ]; then mkdir -p "$$dest/scripts"; cp mpvnet/scripts/*.lua "$$dest/scripts/"; fi; \
	echo "mpvnet: synced conf + scripts -> $$dest/"


windows-terminal:
	@command -v wslpath >/dev/null 2>&1 || { echo "windows-terminal: not WSL, skipping"; exit 0; }
	@dest="$$(wslpath "$$(cmd.exe /c 'echo %LOCALAPPDATA%' 2>/dev/null | tr -d '\r')")/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"; \
	[ -d "$$dest" ] || { echo "windows-terminal: $$dest not found, skipping"; exit 0; }; \
	cp windows-terminal/settings.json "$$dest/settings.json"; \
	echo "windows-terminal: copied settings.json -> $$dest/settings.json"


snapshot: HOME=/tmp/archie-home
snapshot: preflight all
	$(FIND) $$HOME -type l | \
	sort | \
	xargs -I{} zsh -c 'printf "%-45s %s\n" "{}" "$$(readlink -f {})"' | \
	sd $$PWD "REPO" | \
	sd $$HOME "HOME" \
	>snapshot
