#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
tmp_home=$(mktemp -d)
trap 'rm -rf "$tmp_home"' EXIT INT TERM
fake_bin="$tmp_home/bin"

mkdir -p "$fake_bin"
cat > "$fake_bin/aws_completer" <<'EOF'
#!/bin/sh
exit 0
EOF
chmod +x "$fake_bin/aws_completer"

if [ -e "$repo_root/zsh/lib/integrations.zsh" ]; then
  echo "integrations should live under zsh/lib/integrations/*.zsh" >&2
  exit 1
fi

for integration in \
  00-homebrew.zsh \
  10-mise.zsh \
  20-fzf.zsh \
  30-aws.zsh \
  40-claude-code.zsh
do
  path="$repo_root/zsh/lib/integrations/$integration"
  if [ ! -f "$path" ]; then
    echo "missing integration: $path" >&2
    exit 1
  fi
  zsh -n "$path"
done

enabled_output=$(
  HOME="$tmp_home" \
  ZSH="" \
  ZSH_CUSTOM="" \
  ZSH_THEME="" \
  PATH="$fake_bin:/bin" \
  DOTFILES_DISABLE_TMUX_AUTO=1 \
  DOTFILES_TEST_REPO_ROOT="$repo_root" \
  zsh -f -i -c 'unset AWS_DEFAULT_REGION CLAUDE_CODE_NO_FLICKER; source "$DOTFILES_TEST_REPO_ROOT/zsh/zshrc"; print -r -- "aws=$AWS_DEFAULT_REGION claude=$CLAUDE_CODE_NO_FLICKER"'
)

case "$enabled_output" in
  *"aws=ap-northeast-1 claude=1"* ) ;;
  * )
    echo "$enabled_output" >&2
    echo "zshrc did not load integration files" >&2
    exit 1
    ;;
esac

skipped_output=$(
  HOME="$tmp_home" \
  ZSH="" \
  ZSH_CUSTOM="" \
  ZSH_THEME="" \
  PATH="$fake_bin:/bin" \
  DOTFILES_DISABLE_TMUX_AUTO=1 \
  DOTFILES_SKIP_INTEGRATIONS=1 \
  DOTFILES_TEST_REPO_ROOT="$repo_root" \
  zsh -f -i -c 'unset AWS_DEFAULT_REGION CLAUDE_CODE_NO_FLICKER; source "$DOTFILES_TEST_REPO_ROOT/zsh/zshrc"; print -r -- "aws=${AWS_DEFAULT_REGION:-unset} claude=${CLAUDE_CODE_NO_FLICKER:-unset}"'
)

case "$skipped_output" in
  *"aws=unset claude=unset"* ) ;;
  * )
    echo "$skipped_output" >&2
    echo "DOTFILES_SKIP_INTEGRATIONS did not skip integration files" >&2
    exit 1
    ;;
esac
