typeset -ga _dotfiles_omz_candidates
_dotfiles_omz_candidates=(
  "${ZSH:-}"
  "$HOME/.oh-my-zsh"
  "/usr/share/oh-my-zsh"
  "/usr/local/share/oh-my-zsh"
  "/opt/oh-my-zsh"
)

for _dotfiles_omz_dir in "${_dotfiles_omz_candidates[@]}"; do
  if [[ -n "$_dotfiles_omz_dir" && -r "$_dotfiles_omz_dir/oh-my-zsh.sh" ]]; then
    export ZSH="$_dotfiles_omz_dir"
    export ZSH_CUSTOM="${ZSH_CUSTOM:-$DOTFILES_ZSH_DIR/themes}"
    export ZSH_THEME="${ZSH_THEME:-${DOTFILES_ZSH_THEME:-robbyrussell}}"
    export DISABLE_AUTO_UPDATE="${DISABLE_AUTO_UPDATE:-true}"
    zstyle ':omz:update' mode disabled
    plugins=(${=DOTFILES_OMZ_PLUGINS:-git})
    source "$ZSH/oh-my-zsh.sh"
    typeset -g DOTFILES_OMZ_LOADED=1
    break
  fi
done

unset _dotfiles_omz_dir _dotfiles_omz_candidates

if [[ -z ${DOTFILES_OMZ_LOADED:-} ]]; then
  autoload -Uz compinit
  compinit -iC
  PROMPT="${PROMPT:-%n@%m:%~%# }"
fi
