#!/bin/zsh

# install prezto
ln -fsn $PWD/prezto $HOME/.zprezto
setopt EXTENDED_GLOB
for rcfile in $PWD/prezto/runcoms/^README.md(.N); do
  ln -fsn "$rcfile" $HOME/.${rcfile:t}
done

ln -fsn $PWD/prezto-override/zpreztorc $HOME/.zpreztorc
ln -fsn $PWD/prezto-override/zshrc $HOME/.zshrc

if [ ! -d "$HOME/.config" ]; then
  mkdir ~/.config
fi

ln -fsn $PWD/git/.gitconfig ~/.gitconfig
ln -fsn $PWD/git/.gitignore_global ~/.gitignore_global
ln -fsn $PWD/.curlrc ~/.curlrc
ln -fsn $PWD/dircolors-solarized/dircolors.ansi-universal ~/.dircolors
ln -fsn $PWD/Brewfile ~/.Brewfile
ln -fsn $PWD/.config/yabai ~/.config/yabai
ln -fsn $PWD/.config/borders ~/.config/borders

# set up for neovim
mkdir -p ~/.config/nvim
ln -fsn $PWD/.vimrc ~/.config/nvim/init.vim
ln -fsn $PWD/.vimrc ~/.vimrc
