if has("syntax")
	syntax on
endif

set hlsearch
set incsearch

set encoding=utf-8

set autoread
set autowrite
set cursorline
set number
set ruler
set showmatch
set smartcase

set tabstop=2
set shiftwidth=2
set expandtab
set smarttab

set foldenable

set nu

set autoindent
set cindent

set mouse=
set laststatus=2

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

call plug#end()
