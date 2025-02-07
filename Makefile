SCRIPTS_DIRECTORY = $$HOME/.local/scripts

all: directories scripts

clean: clean-directories clean-scripts


directories: clean-directories
	find . -maxdepth 1 \
	       -mindepth 1 \
	       -type d \
	       -not -path '*/.*' \
	       -not -path "*/vendor" \
	       -printf "%P\0" | \
	xargs -0 stow --verbose --target=$$HOME --ignore=scripts --restow

clean-directories:
	mkdir -p $$HOME
	find . -maxdepth 1 \
	       -mindepth 1 \
	       -type d \
	       -not -path '*/.*' \
	       -not -path "*/vendor" \
	       -printf "%P\0" | \
	xargs -0 stow --verbose --target=$$HOME --ignore=scripts --delete


scripts: clean-scripts
	mkdir -p ${SCRIPTS_DIRECTORY}
	find $$PWD/*/.local/scripts/ -type f -exec ln -s "{}" ${SCRIPTS_DIRECTORY}/ \;

clean-scripts:
	mkdir -p ${SCRIPTS_DIRECTORY}
	find $$PWD/*/.local/scripts -maxdepth 1 -type f -printf "%f\n" | \
	xargs -I{} sh -c 'unlink ${SCRIPTS_DIRECTORY}/{} || true'


snapshot: HOME=/tmp/archie-home
snapshot: all
	find $$HOME -type l | \
	sort | \
	xargs -I{} zsh -c 'printf "%-45s %s\n" "{}" "$$(readlink -f {})"' | \
	sd $$PWD "REPO" | \
	sd $$HOME "HOME" \
	>snapshot
