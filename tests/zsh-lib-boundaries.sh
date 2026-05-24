#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
tmp_home=$(mktemp -d)
trap 'rm -rf "$tmp_home"' EXIT INT TERM
fake_bin="$tmp_home/bin"

mkdir -p "$fake_bin"
cat > "$fake_bin/nvim" <<'EOF'
#!/bin/sh
exit 0
EOF
chmod +x "$fake_bin/nvim"

base_output=$(
  HOME="$tmp_home" \
  PATH="$fake_bin:/bin" \
  zsh -f -c "source '$repo_root/zsh/lib/base.zsh'; alias dc >/dev/null 2>&1 || print base-has-no-dc-alias"
)

case "$base_output" in
  *"base-has-no-dc-alias"* ) ;;
  * )
    echo "$base_output" >&2
    echo "base.zsh should not define workflow aliases" >&2
    exit 1
    ;;
esac

conditional_alias_output=$(
  HOME="$tmp_home" \
  PATH="$fake_bin:/bin" \
  zsh -f -c "source '$repo_root/zsh/lib/base.zsh'; source '$repo_root/zsh/lib/aliases.zsh'; alias vi"
)

case "$conditional_alias_output" in
  *"vi=nvim"* | *"vi='nvim'"* ) ;;
  * )
    echo "$conditional_alias_output" >&2
    echo "aliases.zsh did not define vi when nvim exists" >&2
    exit 1
    ;;
esac

# Use one stable alias as a representative loader check. Do not mirror the
# whole alias catalog here; only conditional aliases need direct assertions.
zshrc_output=$(
  HOME="$tmp_home" \
  ZSH="" \
  ZSH_CUSTOM="" \
  ZSH_THEME="" \
  PATH="$fake_bin:/bin" \
  DOTFILES_DISABLE_TMUX_AUTO=1 \
  DOTFILES_SKIP_INTEGRATIONS=1 \
  zsh -f -i -c "source '$repo_root/zsh/zshrc'; alias dc"
)

case "$zshrc_output" in
  *"dc='docker compose'"* ) ;;
  * )
    echo "$zshrc_output" >&2
    echo "zshrc did not load aliases.zsh" >&2
    exit 1
    ;;
esac
