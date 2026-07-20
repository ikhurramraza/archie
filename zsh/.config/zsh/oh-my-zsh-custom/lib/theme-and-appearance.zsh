# Shadows oh-my-zsh's lib/theme-and-appearance.zsh (via $ZSH_CUSTOM). Keeps the
# color setup that the rest of the shell relies on (LS_COLORS drives completion
# colouring), but drops: the `diff --color` probe fork; the test-ls-args `ls`
# probes, whose alias is stripped by the ':omz:*' aliases no zstyle anyway; and
# the ZSH_THEME_*_PROMPT_* vars, which starship makes dead weight.

autoload -U colors && colors

setopt prompt_subst

[[ "$DISABLE_LS_COLORS" != true ]] || return 0

export LSCOLORS="Gxfxcxdxbxegedabagacad"

if [[ -z "$LS_COLORS" ]]; then
  if (( $+commands[dircolors] )); then
    [[ -f "$HOME/.dircolors" ]] \
      && source <(dircolors -b "$HOME/.dircolors") \
      || source <(dircolors -b)
  else
    export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
  fi
fi
