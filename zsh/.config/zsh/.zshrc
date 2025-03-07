#!/usr/bin/zsh

# Set OMZ installation path
export ZSH="$ZDOTDIR/.oh-my-zsh"
export ZSH_CUSTOM="$ZDOTDIR/oh-my-zsh-custom"

# History file settings
export HISTFILE="$XDG_CACHE_HOME/zsh/history"

# OMZ Plugins envs
export BOL_QUIET_MODE=true
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=false
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=false
export HISTORY_SUBSTRING_SEARCH_PREFIXED=true
export VI_MODE_SET_CURSOR=true

plugins=(
  bol
  bundler
  copybuffer
  docker
  docker-compose
  dotenv
  jira
  sudo
  universalarchive
  vi-mode
  z
)

source "$ZDOTDIR/inits"
source "$ZDOTDIR/aliases"

if [[ -f "$ZDOTDIR/overrides" ]]; then
  source "$ZDOTDIR/overrides"
fi
