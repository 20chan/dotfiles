#!/bin/bash

DOTFILES_PATH="${HOME}/.dotfiles"

OHMYZSH_PATH="${HOME}/.oh-my-zsh"
ZSHRC_PATH="${HOME}/.zshrc"
VIMRC_PATH="${HOME}/.vimrc"
TMUX_CONF_PATH="${HOME}/.tmux.conf"
ALACRITTY_PATH="${HOME}/.alacritty.toml"

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

install_vimplug() {
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

# install requirements

[ ! -f ~/.fzf.zsh ] && install_fzf
[ ! -d ~/.oh-my-zsh ] && install_ohmyzsh
[ ! -f ~/.vim/autoload/plug.vim ] && install_vimplug
[ ! -d ~/.tmux/plugins/tpm ] && install_tmux_plugins

# backup existing files

backup_file "${ZSHRC_PATH}"
backup_file "${VIMRC_PATH}"
backup_file "${TMUX_CONF_PATH}"
backup_file "${ALACRITTY_PATH}"

# link files

ln -s "${DOTFILES_PATH}/zshrc" "${ZSHRC_PATH}"
ln -s "${DOTFILES_PATH}/vimrc" "${VIMRC_PATH}"
ln -s "${DOTFILES_PATH}/tmux.conf" "${TMUX_CONF_PATH}"
ln -s "${DOTFILES_PATH}/alacritty.toml" "${ALACRITTY_PATH}"

# patch zsh theme

EASTWOOD_PATH="${DOTFILES_PATH}/patches/eastwood.zsh-theme.patch"
PATCH_MSG="custom eastwood prompt"
if [[ ! $(git -C "${OHMYZSH_PATH}" log --grep="${PATCH_MSG}") ]]; then
    patch -p1 -d "${OHMYZSH_PATH}" < "${EASTWOOD_PATH}"
    git -C "${OHMYZSH_PATH}" commit -am "${PATCH_MSG}"
fi

# git settings

git config --global user.name 20chan
git config --global user.email 2@0chan.dev
git config --global push.default current
