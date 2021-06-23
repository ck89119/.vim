#!/bin/sh

cd ~

[ -e ".vim" ] && rm -rf .vim
git clone https://github.com/ck89119/.vim.git ~/.vim

cd ~/.vim
git submodule update --init --recursive

cd bundle/YouCompleteMe
git submodule update --init --recursive
sudo apt-get install build-essential cmake python-dev clang
./install.py --clang-completer --system-libclang

cd ~/.vim
./install-vimrc.sh

echo "ck89119's vimrc is installed."
