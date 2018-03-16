#!/bin/sh

PACMAN_PACKAGES="
  intel-ucode
  dosfstools
  efibootmgr
  dialog
  linux-firmware
  sudo
  zsh
  zsh-completions
  tmux
  git
  rsync
  openssh
  openssh-server
  networkmanager
  networkmanager-pptp
  neovim
  git-flow
  htop
  diffstat
  sysstat
  pwgen
  acpi
  libjpeg
  libpng
  libmcrypt
  libxml2
  openssl
  tidy
  tree
  unzip
  lsof
  nfs-utils
  traceroute
  avahi
  screenfetch
  fortune-mod
  vagrant
  ansible
  python-pip
  bind-tools
  docker
  docker-compose
  docker-machine
  virtualbox
  mariadb
  jre8-openjdk
  xorg-server
  xorg-server-utils
  xorg-xinit
  xorg-xclock
  xterm
  xf86-video-intel
  xf86-input-libinput
  fcitx
  fcitx-mozc
  fcitx-configtool
  fcitx-im
  gnome-open
  slack-desktop
  dropbox
  mysql-workbench
  xorg-xev
  terminator
  imagemagick
  xsel
  synergy
  cloc
  dunst
  volumeicon
  network-manager-applet
  parcellite
  feh
  xsel
  pavucontrol
"

installed=$(sudo pacman -Qe | awk '{print $1}')
for package in $PACMAN_PACKAGES; do
  if echo "$installed" | grep -q "$package"; then
    echo "${package} already installed."
  else
    sudo pacman -S $package --noconfirm
  fi
done

AUR_PACKAGES="
  i3-wm
  i3lock
  i3status
  dmenu
  lightdm
  lightdm-mini-greeter
  lightdm-webkit2-greeter
  ttf-font-awesome
  ttf-font-awesome-4
  j4-dmenu-desktop-git
  visual-studio-code-bin
  zoom
  nautilus-dropbox
  google-chrome-beta
  profile-sync-daemon
  franz-bin
  asix-ax88179-dkms
  apache-tools
  google-cloud-sdk
  phpstorm
  googler
  pm-utils
  minikube
  kubectl-bin
  kompose-bin
  icu59
"

installed=$(yaourt -Qe | awk '{print $1}')
for package in $AUR_PACKAGES; do
  if echo "$installed" | grep -q "$package"; then
    echo "${package} already installed."
  else
    yaourt -S $package --noconfirm
  fi
done

