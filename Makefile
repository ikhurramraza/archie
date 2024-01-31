SCRIPTS_DIRECTORY = $$HOME/.local/scripts

all: directories scripts

clean: clean-directories clean-scripts


directories: clean-directories
	stow --verbose --target=$$HOME --ignore=scripts --restow */

clean-directories:
	stow --verbose --target=$$HOME --ignore=scripts --delete */


scripts: clean-scripts
	mkdir -p ${SCRIPTS_DIRECTORY}
	find $$PWD/*/.local/scripts/ -type f -exec ln -s "{}" ${SCRIPTS_DIRECTORY}/ \;

clean-scripts:
	mkdir -p ${SCRIPTS_DIRECTORY}
	find ${SCRIPTS_DIRECTORY} -type l -exec unlink "{}" \;
