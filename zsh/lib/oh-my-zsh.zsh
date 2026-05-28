typeset -g _dotfiles_in_container=
if [[ -n "${REMOTE_CONTAINERS:-}" || -n "${CODESPACES:-}" || -n "${DEVCONTAINER:-}" ]]; then
  _dotfiles_in_container=1
fi

# Per-env default theme. Honors DOTFILES_ZSH_THEME set in ~/.zshrc.env.
if [[ -z "${DOTFILES_ZSH_THEME:-}" ]]; then
  if [[ -n "$_dotfiles_in_container" ]]; then
    DOTFILES_ZSH_THEME=amuse
  elif [[ "$OSTYPE" == darwin* ]]; then
    DOTFILES_ZSH_THEME=amuse
  elif [[ "$OSTYPE" == linux* ]]; then
    DOTFILES_ZSH_THEME=amuse
  else
    DOTFILES_ZSH_THEME=robbyrussell
  fi
fi

# Inside containers, prefix the prompt with a colored badge so the shell is easy
# to tell apart from the host. Inserts after a leading newline (themes like ys
# start with one) so it lands on the first visible line without adding a row.
# Override the label with DOTFILES_CONTAINER_BADGE; set it empty to disable.
_dotfiles_prepend_container_badge() {
  [[ -n "$_dotfiles_in_container" ]] || return
  local label="${DOTFILES_CONTAINER_BADGE-🐳 CONTAINER}"
  [[ -n "$label" ]] || return
  local badge="%K{red}%F{white} ${label} %f%k "
  if [[ "$PROMPT" == $'\n'* ]]; then
    PROMPT=$'\n'"${badge}${PROMPT#$'\n'}"
  else
    PROMPT="${badge}${PROMPT}"
  fi
}

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
    plugins=(${=DOTFILES_OMZ_PLUGINS:-git zsh-autosuggestions})
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

_dotfiles_prepend_container_badge
unset -f _dotfiles_prepend_container_badge
unset _dotfiles_in_container
