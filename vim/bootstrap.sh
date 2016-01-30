#!/bin/sh

# install neobundle
if [ ! -d "~/.vim/bundle/neobundle.vim" ]; then
  curl -s https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh|sh
fi
