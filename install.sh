#!/bin/bash

set -ex

DOTFILES_PATH="${HOME}/.dotfiles"

ZSHRC_PATH="${HOME}/.zshrc"
ZSHRC_D_PATH="${HOME}/.zshrc.d"
VIMRC_PATH="${HOME}/.vimrc"
TMUX_CONF_PATH="${HOME}/.tmux.conf"
ALACRITTY_PATH="${HOME}/.alacritty.toml"

install_fzf() {
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
}

install_tmux_plugins() {
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

install_vimplug() {
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_pure() {
  npm install --global pure-prompt
}

install() {
  [ ! -f ~/.fzf.zsh ] && install_fzf
  [ ! -f ~/.vim/autoload/plug.vim ] && install_vimplug
  [ ! -d ~/.tmux/plugins/tpm ] && install_tmux_plugins
}

backup_file() {
  [[ -f "${1}" || -h "${1}" ]] && mv "$1" "${1}.backup"
}

link() {
  backup_file "${ZSHRC_PATH}"
  backup_file "${VIMRC_PATH}"
  backup_file "${TMUX_CONF_PATH}"
  backup_file "${ALACRITTY_PATH}"

  ln -s "${DOTFILES_PATH}/zshrc" "${ZSHRC_PATH}"
  ln -s "${DOTFILES_PATH}/zshrc.d" "${ZSHRC_D_PATH}"
  ln -s "${DOTFILES_PATH}/vimrc" "${VIMRC_PATH}"
  ln -s "${DOTFILES_PATH}/tmux.conf" "${TMUX_CONF_PATH}"
  ln -s "${DOTFILES_PATH}/alacritty.toml" "${ALACRITTY_PATH}"
}

config() {
  git config --global user.name 20chan
  git config --global user.email 2@0chan.dev
  git config --global push.default current
}

until [ "$#" == 0 ]; do
  time $1
  shift
done
