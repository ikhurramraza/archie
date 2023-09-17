# Machine info
export OS="$(uname)"

# Default programs
export EDITOR=nvim
export TERMINAL=wezterm
export BROWSER=firefox

# XDG Dirs
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# ZSH settings
export PROMPT_EOL_MARK=""

# Set language to English
export LANG="en_US.UTF-8"

# Add local scripts to PATH
export PATH="$PATH:$HOME/.local/scripts"

# Add cargo bin directory to PATH
export PATH="$PATH:$CARGO_HOME/bin"

# Set environment variables for XDG compliant paths
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle/config"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export _Z_DATA="$XDG_DATA_HOME/z"

if [[ "$OS" == "Linux" ]]; then
  source "$ZDOTDIR/linux.zsh"
elif [[ "$OS" == "Darwin" ]]; then
  source "$ZDOTDIR/mac.zsh"
fi
