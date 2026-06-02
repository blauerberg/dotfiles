#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

bash -n "$repo_root/.claude/statusline.sh"

if ! command -v jq >/dev/null 2>&1; then
  echo "skip: jq not found"
  exit 0
fi

tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT INT TERM

stdout="$tmp_dir/stdout"
stderr="$tmp_dir/stderr"
marker="STATUSLINE_EVAL_PROOF"

payload='{"model":{"display_name":"demo"},"context_window":{"context_window_size":"$(printf STATUSLINE_EVAL_PROOF >&2)","used_percentage":"$(printf STATUSLINE_EVAL_PROOF >&2)","current_usage":{"input_tokens":"$(printf STATUSLINE_EVAL_PROOF >&2)","cache_creation_input_tokens":0,"cache_read_input_tokens":0},"total_input_tokens":0,"total_output_tokens":0},"rate_limits":{"five_hour":{"used_percentage":"$(printf STATUSLINE_EVAL_PROOF >&2)","resets_at":0},"seven_day":{"used_percentage":0,"resets_at":0}},"workspace":{"current_dir":"."}}'

if ! printf '%s\n' "$payload" | "$repo_root/.claude/statusline.sh" >"$stdout" 2>"$stderr"; then
  cat "$stdout" >&2
  cat "$stderr" >&2
  echo "statusline failed on malformed numeric fields" >&2
  exit 1
fi

if grep -q "$marker" "$stderr"; then
  cat "$stderr" >&2
  echo "statusline executed JSON-derived shell syntax" >&2
  exit 1
fi
