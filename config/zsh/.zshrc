if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$ZDOTDIR/.oh-my-zsh"

HIST_STAMPS="dd.mm.yyy"
ZSH_THEME="powerlevel10k/powerlevel10k"

# OMZ Plugins envs
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=false
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=false
export HISTORY_SUBSTRING_SEARCH_PREFIXED=true

plugins=(
  1password
  archlinux
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
  z
  zsh-history-substring-search
)

source "$ZDOTDIR/inits"
source "$ZDOTDIR/aliases"
