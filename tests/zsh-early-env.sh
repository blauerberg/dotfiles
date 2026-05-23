#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
tmp_home=$(mktemp -d)
trap 'rm -rf "$tmp_home"' EXIT INT TERM

mkdir -p "$tmp_home/.oh-my-zsh"
cat > "$tmp_home/.oh-my-zsh/oh-my-zsh.sh" <<'EOF'
print "theme=$ZSH_THEME"
EOF
cat > "$tmp_home/.zshrc.env" <<'EOF'
export DOTFILES_ZSH_THEME=ys
EOF

output=$(
  HOME="$tmp_home" \
  ZSH="$tmp_home/.oh-my-zsh" \
  ZSH_THEME="" \
  DOTFILES_ZSH_THEME="" \
  PATH="/bin" \
  DOTFILES_DISABLE_TMUX_AUTO=1 \
  DOTFILES_SKIP_INTEGRATIONS=1 \
  zsh -f -i -c "source '$repo_root/zsh/zshrc'"
)

case "$output" in
  *"theme=ys"* ) ;;
  * )
    echo "$output" >&2
    echo ".zshrc.env was not loaded before Oh My Zsh" >&2
    exit 1
    ;;
esac
