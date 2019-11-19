#!/bin/sh

PACMAN_PACKAGES="
  intel-ucode
  dosfstools
  efibootmgr
  dialog
  wpa_supplicant
  linux-firmware
  sudo
  zsh
  zsh-completions
  tmux
  rsync
  git
  neovim
  openssh
  wget
  htop
  ntp
  diffstat
  sysstat
  expac
  pacman-contrib
  pwgen
  acpi
  base-devel
  libjpeg
  libpng
  libmcrypt
  libxml2
  openssl
  tidy
  tree
  lsof
  nfs-utils
  traceroute
  bind-tools
  avahi
  screenfetch
  fortune-mod
  python-pip
  python-tox
  jq
  nmap
  pdnsd
  w3m
  ranger
  xsel
  networkmanager
  pulseaudio
  pulseaudio-bluetooth
  vagrant
  ansible
  docker
  docker-compose
  docker-machine
  python-dockerpty
  python-docker
  virtualbox
  virtualbox-host-dkms
  virtualbox-guest-modules-arch
  terraform
  minikube
  kubectl
  imagemagick
  mariadb-clients
  jre-openjdk
  xorg-server
  xorg-apps
  xorg-xinit
  xorg-xclock
  xterm
  xf86-video-intel
  xf86-input-libinput
  xorg-xev
  fcitx
  fcitx-mozc
  fcitx-configtool
  fcitx-im
  rxvt-unicode
  rxvt-unicode-terminfo
  urxvt-perls
  terminator
  xsel
  blueman
  blueman-applet
  mysql-workbench
  archlinux-wallpaper
  cloc
  dunst
  volumeicon
  network-manager-applet
  parcellite
  feh
  pavucontrol
  ttf-dejavu
  bluez
  re2c
  iotop
  compton
  lightdm
  lightdm-mini-greeter
  lightdm-webkit2-greeter
  i3-gaps
  i3lock
  i3status
  i3blocks
  dmenu
  nemo
  redshift
  simplescreenrecorder
  arandr
  ttf-font-awesome
  firefox
  libreoffice-fresh
  libreoffice-fresh-ja
"

installed=$(sudo pacman -Qe | awk '{print $1}')
for package in $PACMAN_PACKAGES; do
  if echo "$installed" | grep -q "$package"; then
    echo "${package} already installed."
  else
    sudo pacman -S $package --noconfirm --needed
  fi
done

# install yay if isn't exists.
type yay > /dev/null 2>&1
if [ $? -ne 0 ]; then
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm --needed
fi

AUR_PACKAGES="
  gitflow-avh
  ttf-font-awesome-4
  j4-dmenu-desktop-git
  rofi
  visual-studio-code-bin
  direnv
  unzip-iconv
  zoom
  apache-tools
  google-cloud-sdk
  phpstorm
  googler
  pm-utils
  kompose-bin
  icu59
  slack-desktop
  dropbox
  universal-ctags-git
  urxvt-resize-font-git
  networkmanager-l2tp
  libreswan
  google-chrome
"

installed=$(yay -Qe | awk '{print $1}')
for package in $AUR_PACKAGES; do
  if echo "$installed" | grep -q "$package"; then
    echo "${package} already installed."
  else
    yay -S $package --noconfirm --needed
  fi
done

