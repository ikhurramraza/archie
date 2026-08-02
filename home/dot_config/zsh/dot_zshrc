#!/usr/bin/zsh

# Set OMZ installation path
export ZSH="$ZDOTDIR/.oh-my-zsh"
export ZSH_CUSTOM="$ZDOTDIR/oh-my-zsh-custom"

# History file settings
export HISTFILE="$XDG_STATE_HOME/zsh/history"
mkdir -p "${HISTFILE:h}"

# OMZ Plugins envs
export BOL_QUIET_MODE=true
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=false
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=false
export HISTORY_SUBSTRING_SEARCH_PREFIXED=true
export VI_MODE_SET_CURSOR=true
export VI_MODE_DISABLE_CLIPBOARD=true

plugins=(
  bol
  bundler
  copybuffer
  jira
  sudo
  vi-mode
  z
)

source "$ZDOTDIR/inits"
source "$ZDOTDIR/aliases"

if [[ -f "$ZDOTDIR/overrides" ]]; then
  source "$ZDOTDIR/overrides"
fi

# Compile the config + oh-my-zsh sources to wordcode so zsh loads them without
# re-parsing ~168KB of script each startup. Recompiled automatically when a
# source changes (zsh uses a .zwc only while it is newer than its source).
() {
  emulate -L zsh
  local f p
  local -a srcs
  srcs=(
    $ZDOTDIR/.zshrc $ZDOTDIR/inits $ZDOTDIR/aliases $ZDOTDIR/overrides
    $ZSH/oh-my-zsh.sh $ZSH/lib/*.zsh(N) $ZSH_CUSTOM/lib/*.zsh(N)
  )
  for p in $plugins; do
    srcs+=($ZSH/plugins/$p/*.plugin.zsh(N) $ZSH_CUSTOM/plugins/$p/*.plugin.zsh(N))
  done
  for f in $srcs; do
    [[ -s $f && ( ! -s $f.zwc || $f -nt $f.zwc ) ]] && zcompile -R -- $f 2>/dev/null
  done
}
