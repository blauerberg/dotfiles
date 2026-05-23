#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
tmp_home=$(mktemp -d)
trap 'rm -rf "$tmp_home"' EXIT INT TERM

mkdir -p "$tmp_home/.oh-my-zsh/themes"
cat > "$tmp_home/.oh-my-zsh/oh-my-zsh.sh" <<'EOF'
theme_file="$ZSH/themes/$ZSH_THEME.zsh-theme"
if [ -r "$theme_file" ]; then
  source "$theme_file"
fi
EOF
cat > "$tmp_home/.oh-my-zsh/themes/sample.zsh-theme" <<'EOF'
PROMPT="sample-theme:%m:%~ %# "
EOF

output=$(
  HOME="$tmp_home" \
  ZSH="$tmp_home/.oh-my-zsh" \
  PATH="/bin" \
  DOTFILES_DISABLE_TMUX_AUTO=1 \
  DOTFILES_SKIP_INTEGRATIONS=1 \
  zsh -f -i -c "source '$repo_root/zsh/zshrc'; dot_prompt_preview sample"
)

case "$output" in
  *"== sample =="* ) ;;
  * )
    echo "$output" >&2
    echo "theme header was not printed" >&2
    exit 1
    ;;
esac

case "$output" in
  *"sample-theme:"* ) ;;
  * )
    echo "$output" >&2
    echo "theme prompt was not previewed" >&2
    exit 1
    ;;
esac
