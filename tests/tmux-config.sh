#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
tmux_conf="$repo_root/tmux.conf"

assert_contains() {
  pattern=$1
  if ! grep -Fq -- "$pattern" "$tmux_conf"; then
    echo "missing tmux config: $pattern" >&2
    exit 1
  fi
}

assert_contains 'set-option -g status-right-length 45'
assert_contains 'uname -r | grep -q -- "-nvidia$"'
assert_contains 'set-option -g status-right-length 80'
assert_contains 'set-option -g status-right "#(~/.local/bin/spark-monitor --statusline)"'
