#!/bin/zsh

PWD=$(pwd)

ln -fsn $PWD/.xprofile ~/.xprofile
ln -fsn $PWD/.Xresources ~/.Xresources
ln -fsn $PWD/.i3blocks.conf ~/.i3blocks.conf
ln -fsn $PWD/.config/i3 ~/.config/i3
ln -fsn $PWD/.config/i3status ~/.config/i3status
ln -fsn $PWD/.config/dunst ~/.config/dunst
sudo ln -fsn $PWD/usr/lib/i3blocks/memory /usr/lib/i3blocks/memory
sudo ln -fsn $PWD/etc/ppp/if-up.d/10-mtu.sh /etc/ppp/if-up.d/10-mtu.sh
sudo ln -fsn $PWD/usr/share/pulseaudio/alsa-mixer/paths/analog-input-internal-mic.conf /usr/share/pulseaudio/alsa-mixer/paths/analog-input-internal-mic.conf
#sudo ln -fsn $PWD/etc/X11/xorg.conf.d/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf
