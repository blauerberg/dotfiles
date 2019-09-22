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

TMUX_VERSION=$(tmux -V|cut -d " " -f2)
case $TMUX_VERSION in
  1*)
    ln -fsn $PWD/tmux/tmux-1.x.conf ~/.tmux.conf
    ;;
  *)
    ln -fsn $PWD/tmux/tmux-2.x.conf ~/.tmux.conf
    ;;
esac

ln -fsn $PWD/git/gitconfig ~/.gitconfig
ln -fsn $PWD/git/gitignore_global ~/.gitignore_global
ln -fsn $PWD/.curlrc ~/.curlrc
ln -fsn $PWD/.gemrc ~/.gemrc
ln -fsn $PWD/vim ~/.vim
ln -fsn $PWD/vim/.vimrc ~/.vimrc
ln -fsn $PWD/dircolors-solarized/dircolors.ansi-universal ~/.dir_colors

# set up for neovim
if [ ! -d "~/.config" ]; then
  mkdir ~/.config
fi
ln -fsn $PWD/vim ~/.config/nvim
ln -fsn $PWD/vim/.vimrc ~/.config/nvim/init.vim
ln -fsn $PWD/ranger ~/.config/ranger

# install neobundle
source $PWD/vim/bootstrap.sh
