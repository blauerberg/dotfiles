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
  networkmanager
  networkmanager-pptp
  pulseaudio
  pulseaudio-bluetooth
  neovim
  python-neovim
  git-flow
  wget
  htop
  ntp
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
  python-tox
  bind-tools
  docker
  docker-compose
  docker-machine
  python-dockerpty
  python-docker
  virtualbox
  virtualbox-host-dkms
  virtualbox-guest-modules-arch
  mariadb-clients
  jre8-openjdk
  xorg-server
  xorg-apps
  xorg-xinit
  xorg-xclock
  xterm
  xf86-video-intel
  xf86-input-libinput
  fcitx
  fcitx-mozc
  fcitx-configtool
  fcitx-im
  blueman
  blueman-applet
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
  firefox
  archlinux-wallpaper
  ttf-dejavu
  conky
  bluez
  ctags
  jq
  nmap
  pdnsd
  re2c
  iotop
  compton
  i3-gaps
  simplescreenrecorder
"

installed=$(sudo pacman -Qe | awk '{print $1}')
for package in $PACMAN_PACKAGES; do
  if echo "$installed" | grep -q "$package"; then
    echo "${package} already installed."
  else
    sudo pacman -S $package --noconfirm --needed
  fi
done

AUR_PACKAGES="
  i3lock
  i3status
  i3blocks
  dmenu
  lightdm
  lightdm-mini-greeter
  lightdm-webkit2-greeter
  ttf-font-awesome
  ttf-font-awesome-4
  j4-dmenu-desktop-git
  rofi
  visual-studio-code-bin
  direnv
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
  python-azure-cli
  python-azure-multiapi-storage
  redshift
  terraform
  slack-desktop
  dropbox
  libreoffice-fresh
  libreoffice-fresh-ja
"

installed=$(yaourt -Qe | awk '{print $1}')
for package in $AUR_PACKAGES; do
  if echo "$installed" | grep -q "$package"; then
    echo "${package} already installed."
  else
    yaourt -S $package --noconfirm --needed
  fi
done

