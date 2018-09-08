#!/bin/sh

# install neobundle
if [ ! -d "~/.vim/bundle/neobundle.vim" ]; then
  curl -s https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh|sh
fi

if [ ! -d "~/.vim/colors" ]; then
  mkdir ~/.vim/colors
fi

ln -fsn ~/.vim/external/colors/vim-atom-dark/colors/atom-dark.vim ~/.vim/colors/atom-dark.vim
ln -fsn ~/.vim/external/colors/vim-atom-dark/colors/atom-dark-256.vim ~/.vim/colors/atom-dark-256.vim
