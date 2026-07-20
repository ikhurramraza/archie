# Shadows oh-my-zsh's lib/misc.zsh (preferred over it via $ZSH_CUSTOM) to drop
# its $+commands[ack-grep] probe, which triggers a full PATH walk across the slow
# /mnt/c dirs on every startup. Keeps only the parts that still do something here
# (the *-magic block is disabled via DISABLE_MAGIC_FUNCTIONS, and the afind / _
# aliases are stripped by the ':omz:*' aliases no zstyle).

setopt multios
setopt long_list_jobs
setopt interactivecomments

if (( ${+commands[less]} )); then
  env_default 'PAGER' 'less'
  env_default 'LESS' '-R'
elif (( ${+commands[more]} )); then
  env_default 'PAGER' 'more'
fi
