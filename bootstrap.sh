#!/bin/zsh

PWD=$(pwd)
HOME="${ZDOTDIR:-$HOME}"
git submodule update --init --recursive

# install prezto
ln -fsn $PWD/prezto $HOME/.zprezto
setopt EXTENDED_GLOB
for rcfile in $PWD/prezto/runcoms/^README.md(.N); do
  ln -fsn "$rcfile" $HOME/.${rcfile:t}
done

ln -fsn $PWD/prezto-override/zpreztorc $HOME/.zpreztorc
ln -fsn $PWD/prezto-override/zshrc_unix $HOME/.zshrc_unix
ln -fsn $PWD/tmux/tmux.conf ~/.tmux.conf
ln -fsn $PWD/git/gitconfig ~/.gitconfig
ln -fsn $PWD/git/gitignore_global ~/.gitignore_global
ln -fsn $PWD/.curlrc ~/.curlrc
ln -fsn $PWD/.gemrc ~/.gemrc
ln -fsn $PWD/vim ~/.vim
ln -fsn $PWD/vim/.vimrc ~/.vimrc

# set up for neovim
if [ ! -d "~/.config" ]; then
  mkdir ~/.config
fi
ln -fsn $PWD/vim ~/.config/nvim
ln -fsn $PWD/vim/.vimrc ~/.config/nvim/init.vim

# install neobundle
source $PWD/vim/bootstrap.sh
