#!/usr/bin/zsh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set OMZ installation path
export ZSH="$ZDOTDIR/.oh-my-zsh"

# History file settings
export HISTFILE="$XDG_CACHE_HOME/zsh/history"

# Set OMZ theme
export ZSH_THEME="powerlevel10k/powerlevel10k"

# OMZ Plugins envs
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=false
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=false
export HISTORY_SUBSTRING_SEARCH_PREFIXED=true
export VI_MODE_SET_CURSOR=true

plugins=(
  1password
  asdf
  bundler
  common-aliases
  copybuffer
  docker
  docker-compose
  fzf
  git
  sudo
  systemadmin
  systemd
  tmux
  universalarchive
  vi-mode
  z
  zsh-history-substring-search
)

if [[ "$OS" == "Darwin" ]]; then
  plugins+=(brew macos)
elif [[ "$OS" == "Linux" ]]; then
  plugins+=(archlinux)
fi

source "$ZDOTDIR/inits"
source "$ZDOTDIR/aliases"
source "$ZDOTDIR/functions"
