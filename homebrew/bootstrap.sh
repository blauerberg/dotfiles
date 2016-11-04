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
  git
  git-flow
  global
  go
  hub
  jq
  neovim/neovim/neovim
  nodebrew
  pandoc
  phpenv
  pwgen
  rbenv
  reattach-to-user-namespace
  ruby-build
  sqlite
  ssh-copy-id
  tmux
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
  phpstorm
  scansnap-manager-ix500
  sequel-pro
  sourcetree
  synergy
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
