#!/bin/sh

# install neobundle
if [ ! -d "~/.vim/bundle/neobundle.vim" ]; then
  curl -s https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh|sh
fi

ln -fsn ~/.vim/external/colors/vim-colors-japanesque/colors/japanesque.vim ~/.vim/colors/japanesque.vim
