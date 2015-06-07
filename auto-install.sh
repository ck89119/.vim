#!/bin/sh

cd ~
[ -e ".vimrc" ] && rm .vimrc
[ -e ".vim" ] && rm -rf .vim

git clone https://github.com/ck89119/.vim.git ~/.vim

cd ~/.vim
git submodule update --init --recursive

cd bundle/YouCompleteMe
#git submodule update --init --recursive
sudo apt-get install build-essential cmake
sudo apt-get install python-dev
./install.sh --clang-completer

cd ~/.vim
./install-vimrc.sh

echo "ck89119's vimrc is installed."
