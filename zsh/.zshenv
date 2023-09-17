# Machine info
export OS="$(uname)"

# Default programs
export EDITOR=nvim
export TERMINAL=kitty
export BROWSER=firefox

# XDG Dirs
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# ZSH settings
export PROMPT_EOL_MARK=""
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Golang path
export GOPATH="$XDG_DATA_HOME/go"

# Rust paths
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# Set language to English
export LANG="en_US.UTF-8"

# Add local scripts to PATH
export PATH="$PATH:$HOME/.local/scripts"

# Add cargo bin directory to PATH
export PATH="$PATH:$CARGO_HOME/bin"

# Add docker config path
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# Add Neovim Mason bin directory to PATH
export PATH="$PATH:$XDG_DATA_HOME/nvim/mason/bin"

if [[ "$OS" == "Linux" ]]; then
  source "$ZDOTDIR/linux.zsh"
elif [[ "$OS" == "Darwin" ]]; then
  source "$ZDOTDIR/mac.zsh"
fi
