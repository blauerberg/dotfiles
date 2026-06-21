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

check_theme "darwin"            "OSTYPE=darwin24"      "amuse"
check_theme "linux"             "OSTYPE=linux-gnu"     "amuse"
check_theme "unknown OS"        "OSTYPE=cygwin"        "robbyrussell"
check_theme "REMOTE_CONTAINERS" "OSTYPE=linux-gnu; REMOTE_CONTAINERS=true" "ys"
check_theme "CODESPACES"        "OSTYPE=linux-gnu; CODESPACES=true"        "ys"
check_theme "DEVCONTAINER"      "OSTYPE=linux-gnu; DEVCONTAINER=1"         "ys"
check_theme "user override"     "OSTYPE=darwin24; DOTFILES_ZSH_THEME=robbyrussell" "robbyrussell"

# Prompt badge: the prompt is prefixed with an environment icon so the shell is
# easy to tell apart by environment -- a whale inside containers, a Tux on a
# Linux host. Labels are controlled by DOTFILES_CONTAINER_BADGE /
# DOTFILES_HOST_BADGE (empty disables them).
check_badge() {
  label=$1
  setup=$2
  mode=$3      # "present" or "absent"
  needle=$4

  prompt=$(zsh -f -c "
    unset DOTFILES_ZSH_THEME REMOTE_CONTAINERS CODESPACES DEVCONTAINER DOTFILES_CONTAINER_BADGE DOTFILES_HOST_BADGE
    $setup
    DOTFILES_OMZ_PLUGINS=git
    source '$repo_root/zsh/lib/oh-my-zsh.zsh' 2>/dev/null
    print -r -- \"\$PROMPT\"
  ")

  case "$prompt" in
    *"$needle"*) found=present ;;
    *)           found=absent ;;
  esac

  if [ "$found" != "$mode" ]; then
    echo "FAIL [$label]: expected badge '$needle' to be $mode, got $found" >&2
    exit 1
  fi
  echo "ok [$label]: badge $found"
}

check_badge "container badge"          "DEVCONTAINER=1"                              present "🐳 "
check_badge "container custom label"   "DEVCONTAINER=1; DOTFILES_CONTAINER_BADGE=dev" present "dev "
check_badge "container badge disabled" "DEVCONTAINER=1; DOTFILES_CONTAINER_BADGE="   absent  "🐳"
check_badge "linux host badge"         "OSTYPE=linux-gnu"                           present "🐧 "
check_badge "host custom label"        "OSTYPE=linux-gnu; DOTFILES_HOST_BADGE=tux"  present "tux "
check_badge "host badge disabled"      "OSTYPE=linux-gnu; DOTFILES_HOST_BADGE="     absent  "🐧"
check_badge "container wins over host" "OSTYPE=linux-gnu; DEVCONTAINER=1"           absent  "🐧"
check_badge "no badge on darwin host"  "OSTYPE=darwin24"                            absent  "🐳"
