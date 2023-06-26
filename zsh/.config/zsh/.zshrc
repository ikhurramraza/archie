#!/usr/bin/zsh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set OMZ installation path
export ZSH="$ZDOTDIR/.oh-my-zsh"
export ZSH_CUSTOM="$ZDOTDIR/oh-my-zsh-custom"

# History file settings
export HISTFILE="$XDG_CACHE_HOME/zsh/history"

# Set OMZ theme
export ZSH_THEME="powerlevel10k/powerlevel10k"

# OMZ Plugins envs
export BOL_QUIET_MODE=true
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=false
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=false
export HISTORY_SUBSTRING_SEARCH_PREFIXED=true
export VI_MODE_SET_CURSOR=true

plugins=(
  ag
  bol
  bundler
  common-aliases
  copybuffer
  docker
  docker-compose
  dotenv
  git
  jira
  npm
  rails
  rake-fast
  sudo
  systemadmin
  systemd
  tmux
  universalarchive
  vi-mode
  z
)

if [[ "$OS" == "Darwin" ]]; then
  plugins+=(brew macos)
fi

source "$ZDOTDIR/inits"
source "$ZDOTDIR/aliases"
source "$ZDOTDIR/functions"

if [[ -f "$ZDOTDIR/overrides" ]]; then
  source "$ZDOTDIR/overrides"
fi
