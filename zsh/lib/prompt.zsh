_dotfiles_prompt_preview_theme_list="${DOTFILES_PROMPT_PREVIEW_THEMES:-}"
typeset -ga DOTFILES_PROMPT_PREVIEW_THEMES
if [[ -n "$_dotfiles_prompt_preview_theme_list" ]]; then
  DOTFILES_PROMPT_PREVIEW_THEMES=(${=${_dotfiles_prompt_preview_theme_list}})
elif (( ${#DOTFILES_PROMPT_PREVIEW_THEMES[@]} == 1 )); then
  DOTFILES_PROMPT_PREVIEW_THEMES=(${=DOTFILES_PROMPT_PREVIEW_THEMES[1]})
fi
unset _dotfiles_prompt_preview_theme_list

dot_prompt_preview() {
  emulate -L zsh
  setopt localoptions no_aliases

  local -a themes
  if (( $# > 0 )); then
    themes=("$@")
  elif (( ${#DOTFILES_PROMPT_PREVIEW_THEMES[@]} > 0 )); then
    themes=("${DOTFILES_PROMPT_PREVIEW_THEMES[@]}")
  else
    local -a theme_files
    theme_files=("$ZSH"/themes/*.zsh-theme(N))
    if [[ -d "$ZSH_CUSTOM/themes" ]]; then
      theme_files+=("$ZSH_CUSTOM"/themes/*.zsh-theme(N))
    fi
    themes=(${theme_files:t:r})
    themes=(${(ou)themes})
  fi

  local theme
  for theme in "${themes[@]}"; do
    printf '== %s ==\n' "$theme"
    ZSH_THEME="$theme" \
    DOTFILES_ZSH_THEME="$theme" \
    DOTFILES_SKIP_INTEGRATIONS=1 \
    DOTFILES_DISABLE_TMUX_AUTO=1 \
      zsh -f -i -c 'source "$1"; print -P "$PROMPT"' _ "$DOTFILES_ZSH_DIR/zshrc" 2>/dev/null
    printf '\n'
  done
}
