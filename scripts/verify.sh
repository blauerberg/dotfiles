#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

for test in "$repo_root"/tests/*.sh; do
  sh "$test"
done

zsh -n "$repo_root/zsh/zshrc"
