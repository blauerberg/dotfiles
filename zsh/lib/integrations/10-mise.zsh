if command -v mise >/dev/null 2>&1; then
  if [[ "${DOTFILES_MISE_MODE:-shims}" == "full" ]]; then
    _dotfiles_mise_activate_cmd=(mise activate zsh)
  else
    _dotfiles_mise_activate_cmd=(mise activate zsh --shims)
  fi
  if _dotfiles_mise_activate=$("${_dotfiles_mise_activate_cmd[@]}" 2>/dev/null); then
    eval "$_dotfiles_mise_activate"
  fi
  if _dotfiles_mise_completion=$(mise completion zsh 2>/dev/null); then
    eval "$_dotfiles_mise_completion"
  fi
  unset _dotfiles_mise_activate _dotfiles_mise_activate_cmd _dotfiles_mise_completion
fi
