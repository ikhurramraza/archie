# Machine info
export OS="$(uname)"

# Docker Compose profile (per host — see nukes/README.md)
case "$(hostname)" in
Cov) export COMPOSE_PROFILES=cov ;;
Dort) export COMPOSE_PROFILES=dort ;;
esac

# Default programs
export EDITOR=nvim
export TERMINAL=ghostty

# XDG Dirs
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# ZSH settings
export PROMPT_EOL_MARK=""

# Set language to English
export LANG="en_US.UTF-8"

# Set environment variables for XDG compliant paths
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle/config"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export _Z_DATA="$XDG_DATA_HOME/z"

# Put user dirs ahead of the inherited (Windows-interop) PATH so command lookups
# hit them before walking the slow /mnt/c 9p dirs.
path=("$HOME/.local/scripts" "$HOME/.local/bin" "$CARGO_HOME/bin" "$GOPATH/bin" $path)

if [[ "$OS" == "Linux" ]]; then
  source "$ZDOTDIR/linux.zsh"
elif [[ "$OS" == "Darwin" ]]; then
  source "$ZDOTDIR/mac.zsh"
fi
