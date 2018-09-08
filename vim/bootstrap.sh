#!/bin/sh

# install dein
if [ ! -d ~/.cache/dein ]; then
  mkdir -p ~/.cache/dein
  case "$(uname -r)" in
    *ARCH*)
      curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
      ;;
    *)
      curl https://raw.githubusercontent.com/Shougo/dein.vim/1.5/bin/installer.sh > /tmp/installer.sh
      ;;
  esac
  sh /tmp/installer.sh ~/.cache/dein
  rm -f /tmp/installer.sh
fi

if [ ! -d ~/.vim/colors ]; then
  mkdir ~/.vim/colors
fi

ln -fsn ~/.vim/external/colors/vim-atom-dark/colors/atom-dark.vim ~/.vim/colors/atom-dark.vim
ln -fsn ~/.vim/external/colors/vim-atom-dark/colors/atom-dark-256.vim ~/.vim/colors/atom-dark-256.vim
