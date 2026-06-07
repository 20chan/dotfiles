export EDITOR="vim"

setopt SHARE_HISTORY HIST_IGNORE_DUPS
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=100000

autoload -Uz compinit
if [[ -n ~/.zcompdump(#qNmh-24) ]]; then
  compinit -C
else
  compinit
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

WORDCHARS=""

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -d ~/.zshrc.d ]
then
  for file in ~/.zshrc.d/*; do
    source "$file"
  done
fi

. "$HOME/.local/bin/env"
