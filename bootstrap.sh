#!/bin/sh

PWD=$(pwd)

ln -s $PWD/.zshrc ~/.zshrc
ln -s $PWD/.zshrc_unix ~/.zshrc_unix
ln -s $PWD/.tmux.conf ~/.tmux.conf
ln -s $PWD/.gitconfig ~/.gitconfig
ln -s $PWD/.gitignore_global ~/.gitignore_global
ln -s $PWD/vim ~/.vim

# install neobundle
source $PWD/vim/bootstrap.sh
