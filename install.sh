#!/bin/bash

DOTFILES_PATH="/home/${USER}/.dotfiles"

OHMYZSH_PATH="/home/${USER}/.oh-my-zsh"
ZSHRC_PATH="/home/${USER}/.zshrc"
VIMRC_PATH="/home/${USER}/.vimrc"

backup_file() {
    mv "$1" "${1}.backup"
}

install_fzf() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

install_ohmyzsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# install requirements

[ ! -f ~/.fzf.zsh ] && install_fzf
[ ! -d ~/.oh-my-zsh ] && install_ohmyzsh

# backup existing files

[[ -f "${ZSHRC_PATH}" || -h "${ZSHRC_PATH}" ]] && backup_file "${ZSHRC_PATH}"
[[ -f "${VIMRC_PATH}" || -h "${VIMRC_PATH}" ]] && backup_file "${VIMRC_PATH}"

# patch

# link files

ln -s "${DOTFILES_PATH}/zshrc" "${ZSHRC_PATH}"
ln -s "${DOTFILES_PATH}/vimrc" "${VIMRC_PATH}"

# patch zsh theme

patch -p1 -d "${OHMYZSH_PATH}" < "${DOTFILES_PATH}/patches/eastwood.zsh-theme.patch"
git -C "${OHMYZSH_PATH}" commit -am "custom eastwood prompt"

# git settings

git config --global push.default current

