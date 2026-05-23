#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

# Per-env default theme is selected by zsh/lib/oh-my-zsh.zsh based on OSTYPE
# and devcontainer markers. The user can override via DOTFILES_ZSH_THEME in
# ~/.zshrc.env. These cases verify each branch in isolation.

check_theme() {
  label=$1
  setup=$2
  expected=$3

  actual=$(zsh -f -c "
    unset DOTFILES_ZSH_THEME REMOTE_CONTAINERS CODESPACES DEVCONTAINER
    $setup
    DOTFILES_OMZ_PLUGINS=git
    source '$repo_root/zsh/lib/oh-my-zsh.zsh' 2>/dev/null
    print -r -- \"\$DOTFILES_ZSH_THEME\"
  ")

  if [ "$actual" != "$expected" ]; then
    echo "FAIL [$label]: expected '$expected', got '$actual'" >&2
    exit 1
  fi
  echo "ok [$label]: $actual"
}

check_theme "darwin"            "OSTYPE=darwin24"      "simple"
check_theme "linux"             "OSTYPE=linux-gnu"     "bira"
check_theme "unknown OS"        "OSTYPE=cygwin"        "robbyrussell"
check_theme "REMOTE_CONTAINERS" "OSTYPE=linux-gnu; REMOTE_CONTAINERS=true" "ys"
check_theme "CODESPACES"        "OSTYPE=linux-gnu; CODESPACES=true"        "ys"
check_theme "DEVCONTAINER"      "OSTYPE=linux-gnu; DEVCONTAINER=1"         "ys"
check_theme "user override"     "OSTYPE=darwin24; DOTFILES_ZSH_THEME=robbyrussell" "robbyrussell"
