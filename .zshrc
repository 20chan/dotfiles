export ZSH="/home/${USER}/.oh-my-zsh"

ZSH_THEME="eastwood"

plugins=(git)

export EDITOR="vim"

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
