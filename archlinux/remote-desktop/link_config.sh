#!/bin/zsh

if [ ! -d "$HOME/.config" ]; then
  mkdir ~/.config
fi

PWD=$(pwd)

ln -fsn $PWD/xprofile ~/.xprofile
ln -fsn $PWD/Xresources ~/.Xresources
ln -fsn $PWD/config/i3 ~/.config/i3
ln -fsn $PWD/config/i3status ~/.config/i3status
ln -fsn $PWD/config/polybar ~/.config/polybar
ln -fsn $PWD/config/dunst ~/.config/dunst

