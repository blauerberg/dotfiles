typeset -ga DOTFILES_PROMPT_PREVIEW_THEMES
DOTFILES_PROMPT_PREVIEW_THEMES=(
  "${DOTFILES_PROMPT_PREVIEW_THEMES[@]:-ys bira robbyrussell agnoster}"
)

dot_prompt_preview() {
  emulate -L zsh
  setopt localoptions no_aliases

  local -a themes
  if (( $# > 0 )); then
    themes=("$@")
  else
    themes=("${DOTFILES_PROMPT_PREVIEW_THEMES[@]}")
  fi

  local theme
  for theme in "${themes[@]}"; do
    printf '== %s ==\n' "$theme"
    ZSH_THEME="$theme" \
    DOTFILES_ZSH_THEME="$theme" \
    DOTFILES_SKIP_INTEGRATIONS=1 \
    DOTFILES_DISABLE_TMUX_AUTO=1 \
      zsh -f -i -c 'source "$1"; print -P "$PROMPT"' _ "$DOTFILES_ZSH_DIR/zshrc"
    printf '\n'
  done
}
