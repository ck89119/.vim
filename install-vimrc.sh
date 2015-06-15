#!/bin/sh

cd ~
[ -e ".vimrc" ] && rm .vimrc
ln -s .vim/vimrc .vimrc
