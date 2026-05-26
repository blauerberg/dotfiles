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

install_zsh_plugin() {
  name=$1
  url=$2
  custom_dir=${ZSH_CUSTOM:-"$repo_root/zsh/custom"}
  plugin_dir="$custom_dir/plugins/$name"

  mkdir -p "$custom_dir/plugins"

  if ! command -v git >/dev/null 2>&1; then
    echo "git not found; skipping zsh plugin install: $name" >&2
    return 0
  fi

  if [ -d "$plugin_dir/.git" ]; then
    git -C "$plugin_dir" pull --ff-only
  elif [ -e "$plugin_dir" ]; then
    echo "zsh plugin already exists; skipping install: $plugin_dir" >&2
  else
    git clone "$url" "$plugin_dir"
  fi
}

install_managed_checkout() {
  name=$1
  url=$2
  vendor_dir=${DOTFILES_VENDOR_DIR:-"$repo_root/vendor"}
  checkout_dir="$vendor_dir/$name"

  mkdir -p "$vendor_dir"

  if ! command -v git >/dev/null 2>&1; then
    echo "git not found; skipping managed checkout install: $name" >&2
    return 0
  fi

  if [ -d "$checkout_dir/.git" ]; then
    git -C "$checkout_dir" pull --ff-only
  elif [ -e "$checkout_dir" ]; then
    echo "managed checkout already exists; skipping install: $checkout_dir" >&2
  else
    git clone "$url" "$checkout_dir"
  fi
}

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/tmux"

install_zsh_plugin \
  zsh-autosuggestions \
  https://github.com/zsh-users/zsh-autosuggestions.git

install_managed_checkout \
  fzf-git.sh \
  https://github.com/junegunn/fzf-git.sh.git

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
ensure_file "$HOME/.zshrc.env"
ensure_file "$HOME/.gitconfig_local"
