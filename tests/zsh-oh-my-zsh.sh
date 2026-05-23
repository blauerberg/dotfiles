#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
tmp_home=$(mktemp -d)
trap 'rm -rf "$tmp_home"' EXIT INT TERM

mkdir -p "$tmp_home/.oh-my-zsh"
cat > "$tmp_home/.oh-my-zsh/oh-my-zsh.sh" <<'EOF'
print "loaded=$ZSH"
print "theme=$ZSH_THEME"
print "custom=$ZSH_CUSTOM"
print "plugins=${plugins[*]}"
EOF

output=$(
  HOME="$tmp_home" \
  ZSH="$tmp_home/.oh-my-zsh" \
  ZSH_THEME="" \
  ZSH_CUSTOM="" \
  PATH="/bin" \
  DOTFILES_DISABLE_TMUX_AUTO=1 \
  DOTFILES_SKIP_INTEGRATIONS=1 \
  DOTFILES_ZSH_THEME="bira" \
  DOTFILES_OMZ_PLUGINS="git fzf" \
  zsh -f -i -c "source '$repo_root/zsh/zshrc'"
)

case "$output" in
  *"loaded=$tmp_home/.oh-my-zsh"* ) ;;
  * )
    echo "$output" >&2
    echo "Oh My Zsh was not loaded from the expected path" >&2
    exit 1
    ;;
esac

case "$output" in
  *"theme=bira"* ) ;;
  * )
    echo "$output" >&2
    echo "DOTFILES_ZSH_THEME was not passed to ZSH_THEME" >&2
    exit 1
    ;;
esac

case "$output" in
  *"custom=$repo_root/zsh/themes"* ) ;;
  * )
    echo "$output" >&2
    echo "ZSH_CUSTOM was not set to the bundled themes directory" >&2
    exit 1
    ;;
esac

case "$output" in
  *"plugins=git fzf"* ) ;;
  * )
    echo "$output" >&2
    echo "DOTFILES_OMZ_PLUGINS was not passed to Oh My Zsh plugins" >&2
    exit 1
    ;;
esac
