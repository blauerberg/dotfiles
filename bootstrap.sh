#!/bin/zsh

PWD=$(pwd)
HOME="${ZDOTDIR:-$HOME}"
git submodule update --init --recursive

# install prezto
ln -s $PWD/prezto $HOME/.zprezto
setopt EXTENDED_GLOB
for rcfile in $PWD/prezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" $HOME/.${rcfile:t}
done

#ln -s $PWD/.zshrc ~/.zshrc
#ln -s $PWD/.zshrc_unix ~/.zshrc_unix
ln -s $PWD/.tmux.conf ~/.tmux.conf
ln -s $PWD/.gitconfig ~/.gitconfig
ln -s $PWD/.gitignore_global ~/.gitignore_global
ln -s $PWD/vim ~/.vim
ln -s $PWD/vim/.vimrc ~/.vimrc


# install neobundle
source $PWD/vim/bootstrap.sh
