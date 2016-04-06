#!/bin/zsh

PWD=$(pwd)
HOME="${ZDOTDIR:-$HOME}"
git submodule update --init --recursive

# install prezto
ln -fs $PWD/prezto $HOME/.zprezto
setopt EXTENDED_GLOB
for rcfile in $PWD/prezto/runcoms/^README.md(.N); do
  ln -fs "$rcfile" $HOME/.${rcfile:t}
done

ln -fs $PWD/prezto-override/zpreztorc $HOME/.zpreztorc
#ln -s $PWD/.zshrc_unix ~/.zshrc_unix
ln -fs $PWD/.tmux.conf ~/.tmux.conf
ln -fs $PWD/.gitconfig ~/.gitconfig
ln -fs $PWD/.gitignore_global ~/.gitignore_global
ln -fs $PWD/vim ~/.vim
ln -fs $PWD/vim/.vimrc ~/.vimrc

# install neobundle
source $PWD/vim/bootstrap.sh
