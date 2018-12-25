#!/bin/sh

# install dein
if [ ! -d ~/.cache/dein ]; then
  mkdir -p ~/.cache/dein
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
  sh /tmp/installer.sh ~/.cache/dein
  rm -f /tmp/installer.sh

  case "$(uname -r)" in
    *ARCH*)
    *Microsoft*)
      ;;
    *)
      cd ~/.cache/dein/repos/github.com/Shougo/dein.vim
      git checkout 1.5
      ;;
  esac
fi

if [ ! -d ~/.vim/colors ]; then
  mkdir ~/.vim/colors
fi

ln -fsn ~/.vim/external/colors/vim-atom-dark/colors/atom-dark.vim ~/.vim/colors/atom-dark.vim
ln -fsn ~/.vim/external/colors/vim-atom-dark/colors/atom-dark-256.vim ~/.vim/colors/atom-dark-256.vim
