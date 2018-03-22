#!/bin/zsh

PWD=$(pwd)

ln -fsn $PWD/.xprofile ~/.xprofile
ln -fsn $PWD/.Xmodmap ~/.Xmodmap
ln -fsn $PWD/.Xresources ~/.Xresources
ln -fsn $PWD/.i3blocks.conf ~/.i3blocks.conf
ln -fsn $PWD/.config/i3 ~/.config/i3
ln -fsn $PWD/.config/i3status ~/.config/i3status
ln -fsn $PWD/.config/dunst ~/.config/dunst
ln -fsn $PWD/.config/psd ~/.config/psd
sudo ln -fsn $PWD/usr/lib/i3blocks/memory /usr/lib/i3blocks/memory
sudo ln -fsn $PWD/etc/X11/xorg.conf.d/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf
