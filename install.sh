#!/bin/bash

DOTFILES_PATH="/home/${USER}/.dotfiles"

ZSHRC_PATH="/home/${USER}/.zshrc"
VIMRC_PATH="/home/${USER}/.vimrc"

backup_file() {
    mv "$1" "${1}.backup"
}

install_fzf() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

# install requirements

[ ! -f ~/.fzf.zsh ] && install_fzf

# backup existing files

[[ -f "${ZSHRC_PATH}" || -h "${ZSHRC_PATH}" ]] && backup_file "${ZSHRC_PATH}"
[[ -f "${VIMRC_PATH}" || -h "${VIMRC_PATH}" ]] && backup_file "${VIMRC_PATH}"

# link files

ln -s "${DOTFILES_PATH}/.zshrc" "${ZSHRC_PATH}"
ln -s "${DOTFILES_PATH}/.vimrc" "${VIMRC_PATH}"

# git settings

git config --global push.default current

