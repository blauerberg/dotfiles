#!/bin/zsh

PWD=$(pwd)

sudo ln -fsn $PWD/usr/lib/i3blocks/memory /usr/lib/i3blocks/memory
sudo ln -fsn $PWD/etc/ppp/ip-up.d/10-mtu.sh /etc/ppp/ip-up.d/10-mtu.sh
sudo ln -fsn $PWD/usr/share/pulseaudio/alsa-mixer/paths/analog-input-internal-mic.conf /usr/share/pulseaudio/alsa-mixer/paths/analog-input-internal-mic.conf
