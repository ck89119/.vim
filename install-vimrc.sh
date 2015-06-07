#!/bin/sh

cd ~
[ -e ".vimrc" ] && rm .vimrc
ln .vim/vimrc .vimrc
