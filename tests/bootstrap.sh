#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
tmp_home=$(mktemp -d)
trap 'rm -rf "$tmp_home"' EXIT INT TERM

HOME="$tmp_home" "$repo_root/bootstrap.sh"

assert_link() {
  path=$1
  target=$2
  if [ ! -L "$path" ]; then
    echo "not a symlink: $path" >&2
    exit 1
  fi
  actual=$(readlink "$path")
  if [ "$actual" != "$target" ]; then
    echo "bad link: $path -> $actual, expected $target" >&2
    exit 1
  fi
}

assert_file() {
  path=$1
  if [ ! -f "$path" ]; then
    echo "missing file: $path" >&2
    exit 1
  fi
}

assert_absent() {
  path=$1
  if [ -e "$path" ] || [ -L "$path" ]; then
    echo "unexpected path: $path" >&2
    exit 1
  fi
}

assert_link "$tmp_home/.zshrc" "$repo_root/zsh/zshrc"
assert_link "$tmp_home/.gitconfig" "$repo_root/git/.gitconfig"
assert_link "$tmp_home/.gitignore_global" "$repo_root/git/.gitignore_global"
assert_link "$tmp_home/.curlrc" "$repo_root/.curlrc"
assert_link "$tmp_home/.editorconfig" "$repo_root/.editorconfig"
assert_link "$tmp_home/.vimrc" "$repo_root/.vimrc"
assert_link "$tmp_home/.config/nvim/init.vim" "$repo_root/.vimrc"
assert_link "$tmp_home/.config/tmux/tmux.conf" "$repo_root/tmux.conf"
assert_link "$tmp_home/.config/ghostty" "$repo_root/.config/ghostty"

assert_file "$tmp_home/.zshrc.local"
assert_file "$tmp_home/.gitconfig_local"
assert_absent "$tmp_home/.zprezto"
assert_absent "$tmp_home/.zpreztorc"
assert_absent "$tmp_home/.Brewfile"
assert_absent "$tmp_home/.dircolors"
