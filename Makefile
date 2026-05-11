FIND := $(shell command -v gfind >/dev/null 2>&1 && echo gfind || echo find)

SCRIPTS_DIRECTORY = $$HOME/.local/scripts

.PHONY: preflight all clean directories clean-directories scripts clean-scripts snapshot

preflight:
	@$(FIND) . -maxdepth 0 -printf "" 2>/dev/null || { \
		echo "error: GNU find required (with -printf support)." >&2; \
		echo "       on macOS: brew install findutils  (provides 'gfind')." >&2; \
		exit 1; \
	}

all: preflight directories scripts

clean: preflight clean-directories clean-scripts


directories: clean-directories
	$(FIND) . -maxdepth 1 \
	       -mindepth 1 \
	       -type d \
	       -not -path '*/.*' \
	       -not -path "*/vendor" \
	       -printf "%P\0" | \
	xargs -0 stow --verbose --target=$$HOME --ignore=scripts --restow

clean-directories:
	mkdir -p $$HOME
	$(FIND) . -maxdepth 1 \
	       -mindepth 1 \
	       -type d \
	       -not -path '*/.*' \
	       -not -path "*/vendor" \
	       -printf "%P\0" | \
	xargs -0 stow --verbose --target=$$HOME --ignore=scripts --delete


scripts: clean-scripts
	mkdir -p ${SCRIPTS_DIRECTORY}
	$(FIND) $$PWD/*/.local/scripts/ -type f -exec ln -s "{}" ${SCRIPTS_DIRECTORY}/ \;

clean-scripts:
	mkdir -p ${SCRIPTS_DIRECTORY}
	$(FIND) $$PWD/*/.local/scripts -maxdepth 1 -type f -printf "%f\n" | \
	xargs -I{} sh -c 'unlink ${SCRIPTS_DIRECTORY}/{} || true'


snapshot: HOME=/tmp/archie-home
snapshot: preflight all
	$(FIND) $$HOME -type l | \
	sort | \
	xargs -I{} zsh -c 'printf "%-45s %s\n" "{}" "$$(readlink -f {})"' | \
	sd $$PWD "REPO" | \
	sd $$HOME "HOME" \
	>snapshot
