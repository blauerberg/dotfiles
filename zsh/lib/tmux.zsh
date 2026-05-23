if [[ "$OSTYPE" == darwin* ]]; then
  return 0
fi

if [[ -n "${TMUX:-}" || -n "${DOTFILES_DISABLE_TMUX_AUTO:-}" ]]; then
  return 0
fi

if ! command -v tmux >/dev/null 2>&1; then
  return 0
fi

exec tmux new-session -As "${DOTFILES_TMUX_SESSION:-main}"
