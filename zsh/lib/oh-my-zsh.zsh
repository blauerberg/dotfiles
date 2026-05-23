# Per-env default theme. Honors DOTFILES_ZSH_THEME set in ~/.zshrc.env.
if [[ -z "${DOTFILES_ZSH_THEME:-}" ]]; then
  if [[ -n "${REMOTE_CONTAINERS:-}" || -n "${CODESPACES:-}" || -n "${DEVCONTAINER:-}" ]]; then
    DOTFILES_ZSH_THEME=ys
  elif [[ "$OSTYPE" == darwin* ]]; then
    DOTFILES_ZSH_THEME=simple
  elif [[ "$OSTYPE" == linux* ]]; then
    DOTFILES_ZSH_THEME=bira
  else
    DOTFILES_ZSH_THEME=robbyrussell
  fi
fi

typeset -ga _dotfiles_omz_candidates
_dotfiles_omz_candidates=(
  "${ZSH:-}"
  "$HOME/.oh-my-zsh"
)

for _dotfiles_omz_dir in "${_dotfiles_omz_candidates[@]}"; do
  if [[ -n "$_dotfiles_omz_dir" && -r "$_dotfiles_omz_dir/oh-my-zsh.sh" ]]; then
    export ZSH="$_dotfiles_omz_dir"
    export ZSH_CUSTOM="${ZSH_CUSTOM:-$DOTFILES_ZSH_DIR/custom}"
    export ZSH_THEME="${ZSH_THEME:-$DOTFILES_ZSH_THEME}"
    zstyle ':omz:update' mode disabled
    plugins=(${=DOTFILES_OMZ_PLUGINS:-git})
    source "$ZSH/oh-my-zsh.sh"
    typeset -g DOTFILES_OMZ_LOADED=1
    # oh-my-zsh forces `alias ls='ls -G'`, which means --no-group on GNU ls.
    if command ls --color=auto / >/dev/null 2>&1; then
      alias ls="ls --color=auto"
    fi
    break
  fi
done

unset _dotfiles_omz_dir _dotfiles_omz_candidates

if [[ -z ${DOTFILES_OMZ_LOADED:-} ]]; then
  autoload -Uz compinit
  compinit -iC
  PROMPT="${PROMPT:-%n@%m:%~%# }"
fi
