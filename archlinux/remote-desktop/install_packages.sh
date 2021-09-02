#!/bin/sh

PACMAN_PACKAGES="
  sudo
  zsh
  zsh-completions
  tmux
  rsync
  git
  neovim
  python-neovim
  wget
  ntp
  diffstat
  pwgen
  base-devel
  tree
  lsof
  traceroute
  bind-tools
  screenfetch
  jq
  nmap
  ranger
  docker
  docker-compose
  docker-machine
  python-dockerpty
  python-docker
  xorg-server
  xterm
  fcitx
  fcitx-mozc
  fcitx-configtool
  fcitx-im
  rxvt-unicode
  rxvt-unicode-terminfo
  urxvt-perls
  archlinux-wallpaper
  feh
  ttf-dejavu
  ttf-font-awesome
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  picom
  i3-gaps
  i3lock
  i3status
  dmenu
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
  j4-dmenu-desktop-git
  rofi
  polybar
  visual-studio-code-bin
  direnv
  unzip-iconv
  google-cloud-sdk
  urxvt-resize-font-git
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

