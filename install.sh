#!/bin/bash

DOTFILES_PATH="/home/${USER}/.dotfiles"

OHMYZSH_PATH="/home/${USER}/.oh-my-zsh"
ZSHRC_PATH="/home/${USER}/.zshrc"
VIMRC_PATH="/home/${USER}/.vimrc"
TMUX_CONF_PATH="/home/${USER}/.tmux.conf"

backup_file() {
    [[ -f "${1}" || -h "${1}" ]] && mv "$1" "${1}.backup"
}

install_fzf() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

install_tmux_plugins() {
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

install_ohmyzsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# install requirements

[ ! -f ~/.fzf.zsh ] && install_fzf
[ ! -d ~/.oh-my-zsh ] && install_ohmyzsh
install_tmux_plugins

# backup existing files

backup_file "${ZSHRC_PATH}"
backup_file "${VIMRC_PATH}"
backup_file "${TMUX_CONF_PATH}"

# link files

ln -s "${DOTFILES_PATH}/zshrc" "${ZSHRC_PATH}"
ln -s "${DOTFILES_PATH}/vimrc" "${VIMRC_PATH}"
ln -s "${DOTFILES_PATH}/tmux.conf" "${TMUX_CONF_PATH}"

# patch zsh theme

EASTWOOD_PATH="${DOTFILES_PATH}/patches/eastwood.zsh-theme.patch"
PATCH_MSG="custom eastwood prompt"
if [[ ! $(git -C "${OHMYZSH_PATH}" log --grep="${PATCH_MSG}") ]]; then
    patch -p1 -d "${OHMYZSH_PATH}" < "${EASTWOOD_PATH}"
    git -C "${OHMYZSH_PATH}" commit -am "${PATCH_MSG}"
fi

# git settings

git config --global push.default current

