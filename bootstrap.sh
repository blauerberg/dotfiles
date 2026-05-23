#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

link_file() {
  src=$1
  dst=$2
  ln -fsn "$src" "$dst"
}

ensure_file() {
  path=$1
  if [ ! -e "$path" ]; then
    : > "$path"
  fi
}

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/tmux"

link_file "$repo_root/zsh/zshrc" "$HOME/.zshrc"
link_file "$repo_root/git/.gitconfig" "$HOME/.gitconfig"
link_file "$repo_root/git/.gitignore_global" "$HOME/.gitignore_global"
link_file "$repo_root/.curlrc" "$HOME/.curlrc"
link_file "$repo_root/.editorconfig" "$HOME/.editorconfig"
link_file "$repo_root/.vimrc" "$HOME/.vimrc"
link_file "$repo_root/.vimrc" "$HOME/.config/nvim/init.vim"
link_file "$repo_root/tmux.conf" "$HOME/.config/tmux/tmux.conf"

if [ -d "$repo_root/.config/ghostty" ]; then
  link_file "$repo_root/.config/ghostty" "$HOME/.config/ghostty"
fi

ensure_file "$HOME/.zshrc.local"
ensure_file "$HOME/.gitconfig_local"
