#!/bin/sh

if [[ ! $OSTYPE == darwin* ]]; then
  # nothing to do
  exit
fi

if ! which -s brew; then
  echo -n "Installing homebrew... "
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  hash -r
  echo "done."
fi

BREW_PACKAGES="
  ansible
  awscli
  ctags
  direnv
  fswatch
  git
  git-flow
  global
  go
  hub
  jq
  neovim/neovim/neovim
  nodebrew
  pandoc
  pwgen
  rbenv
  re2c
  reattach-to-user-namespace
  rsync
  ruby-build
  sqlite
  ssh-copy-id
  tmux
  unison
  vim
  watchman
  zsh
  zsh-completions
"

installed=$(brew list -1)
for package in $BREW_PACKAGES; do
  if echo "$installed" | grep -q "^$(basename $package)"; then
    echo "${package} already installed."
  else
    brew install $package
  fi
done

CASK_PACKAGES="
  amazon-drive
  amazon-music
  appcleaner
  atom
  dropbox
  flux
  iterm2
  google-chrome
  google-japanese-ime
  gyazo
  scansnap-manager-ix500
  sequel-pro
  synergy
  vagrant
  vagrant-manager
  virtualbox
  visual-studio-code
  wireshark
  zoomus
"

for package in $CASK_PACKAGES; do
  if echo "$installed" | grep -q "^$(basename $package)"; then
    echo "${package} already installed."
  else
    brew cask install $package
  fi
done
