SCRIPTS_DIRECTORY = $$HOME/.local/scripts

all: directories scripts

clean: clean-directories clean-scripts


directories: clean-directories
	stow --verbose --target=$$HOME --ignore=scripts --restow */

clean-directories:
	mkdir -p $$HOME
	stow --verbose --target=$$HOME --ignore=scripts --delete */


scripts: clean-scripts
	mkdir -p ${SCRIPTS_DIRECTORY}
	find $$PWD/*/.local/scripts/ -type f -exec ln -s "{}" ${SCRIPTS_DIRECTORY}/ \;

clean-scripts:
	mkdir -p ${SCRIPTS_DIRECTORY}
	find ${SCRIPTS_DIRECTORY} -type l -exec unlink "{}" \;


snapshot: HOME=/tmp/archie-home
snapshot: all
	find $$HOME -type l | \
	sort | \
	xargs -I{} zsh -c 'printf "%-45s %s\n" "{}" "$$(readlink -f {})"' | \
	sd $$PWD "REPO" | \
	sd $$HOME "HOME" \
	>snapshot
