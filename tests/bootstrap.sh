#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
tmp_home=$(mktemp -d)
trap 'rm -rf "$tmp_home"' EXIT INT TERM
tmp_custom="$tmp_home/zsh-custom"
tmp_vendor="$tmp_home/vendor"
fake_bin="$tmp_home/bin"
git_log="$tmp_home/git.log"

mkdir -p "$fake_bin"
cat > "$fake_bin/git" <<'EOF'
#!/bin/sh
set -eu

printf '%s\n' "$*" >> "$DOTFILES_TEST_GIT_LOG"

case "$1" in
  clone)
    mkdir -p "$3"
    ;;
  -C)
    ;;
  *)
    echo "unexpected git command: $*" >&2
    exit 1
    ;;
esac
EOF
chmod +x "$fake_bin/git"

HOME="$tmp_home" \
PATH="$fake_bin:$PATH" \
DOTFILES_TEST_GIT_LOG="$git_log" \
ZSH_CUSTOM="$tmp_custom" \
DOTFILES_VENDOR_DIR="$tmp_vendor" \
"$repo_root/bootstrap.sh"

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

assert_dir() {
  path=$1
  if [ ! -d "$path" ]; then
    echo "missing directory: $path" >&2
    exit 1
  fi
}

assert_link "$tmp_home/.zshrc" "$repo_root/zsh/zshrc"
assert_link "$tmp_home/.gitconfig" "$repo_root/git/.gitconfig"
assert_link "$tmp_home/.gitignore_global" "$repo_root/git/.gitignore_global"
assert_link "$tmp_home/.curlrc" "$repo_root/.curlrc"
assert_link "$tmp_home/.editorconfig" "$repo_root/.editorconfig"
assert_link "$tmp_home/.vimrc" "$repo_root/.vimrc"
assert_link "$tmp_home/.config/nvim" "$repo_root/.config/nvim"
assert_link "$tmp_home/.config/tmux/tmux.conf" "$repo_root/tmux.conf"
assert_link "$tmp_home/.config/ghostty" "$repo_root/.config/ghostty"

assert_file "$tmp_home/.zshrc.local"
assert_file "$tmp_home/.zshrc.env"
assert_file "$tmp_home/.gitconfig_local"
assert_dir "$tmp_custom/plugins/zsh-autosuggestions"
assert_dir "$tmp_vendor/fzf-git.sh"

if ! grep -qx "clone https://github.com/zsh-users/zsh-autosuggestions.git $tmp_custom/plugins/zsh-autosuggestions" "$git_log"; then
  cat "$git_log" >&2
  echo "zsh-autosuggestions was not cloned to the custom plugin directory" >&2
  exit 1
fi

if ! grep -qx "clone https://github.com/junegunn/fzf-git.sh.git $tmp_vendor/fzf-git.sh" "$git_log"; then
  cat "$git_log" >&2
  echo "fzf-git.sh was not cloned to the vendor directory" >&2
  exit 1
fi
