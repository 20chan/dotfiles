export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="eastwood"

plugins=(git)

export EDITOR="vim"

bindkey "\x1bU" backward-kill-line

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -d ~/.zshrc.d ]
then
    for file in ~/.zshrc.d/*; do
        source "$file"
    done
fi

. "$HOME/.local/bin/env"
