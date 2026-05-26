_dotfiles_unbind_fzf_git_control_bindings() {
  local key keymap
  for keymap in emacs viins vicmd; do
    for key in f b t r h s l e w; do
      bindkey -M "$keymap" -r "^g^$key" 2>/dev/null
    done
  done
}

_dotfiles_filter_fzf_git_options() {
  local arg bind_arg callback index
  local -a args

  callback=$1
  shift

  for (( index = 1; index <= $#; index++ )); do
    arg="${argv[index]}"
    if [[ "$arg" == --bind ]]; then
      (( index++ ))
      bind_arg="${argv[index]}"
      bind_arg="${bind_arg//,alt-r:toggle-raw/}"
      bind_arg="${bind_arg//alt-r:toggle-raw,/}"
      bind_arg="${bind_arg//alt-r:toggle-raw/}"
      if [[ -n "$bind_arg" ]]; then
        args+=(--bind "$bind_arg")
      fi
    elif [[ "$arg" == --bind=* ]]; then
      bind_arg="${arg#--bind=}"
      bind_arg="${bind_arg//,alt-r:toggle-raw/}"
      bind_arg="${bind_arg//alt-r:toggle-raw,/}"
      bind_arg="${bind_arg//alt-r:toggle-raw/}"
      if [[ -n "$bind_arg" ]]; then
        args+=("--bind=$bind_arg")
      fi
    else
      args+=("$arg")
    fi
  done

  "$callback" "$args[@]"
}

_dotfiles_fzf_git_fzf_without_tmux() {
  fzf --height 50% \
    --layout reverse --multi --border \
    --preview-window 'right,50%' \
    --bind 'ctrl-/:change-preview-window(down,50%|hidden|)' "$@"
}

_dotfiles_fzf_supports() {
  fzf "$@" --filter '' </dev/null >/dev/null 2>&1
  [[ $? -ne 2 ]]
}

if [[ -o zle && -t 0 ]] && command -v fzf >/dev/null 2>&1; then
  if _dotfiles_fzf_init=$(fzf --zsh 2>/dev/null); then
    eval "$_dotfiles_fzf_init"
  else
    for _dotfiles_fzf_file in \
      /usr/share/doc/fzf/examples/key-bindings.zsh \
      /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    do
      if [[ -r "$_dotfiles_fzf_file" ]]; then
        source "$_dotfiles_fzf_file"
        break
      fi
    done
  fi
  _dotfiles_fzf_git="$DOTFILES_ZSH_DIR/../vendor/fzf-git.sh/fzf-git.sh"
  if [[ -r "$_dotfiles_fzf_git" ]]; then
    source "$_dotfiles_fzf_git"
    if ! _dotfiles_fzf_supports --tmux 90%,70%; then
      if _dotfiles_fzf_supports --bind 'alt-r:toggle-raw'; then
        _fzf_git_fzf() { _dotfiles_fzf_git_fzf_without_tmux "$@" }
      else
        _fzf_git_fzf() { _dotfiles_filter_fzf_git_options _dotfiles_fzf_git_fzf_without_tmux "$@" }
      fi
    elif ! _dotfiles_fzf_supports --bind 'alt-r:toggle-raw'; then
      functions -c _fzf_git_fzf _dotfiles_fzf_git_fzf
      _fzf_git_fzf() { _dotfiles_filter_fzf_git_options _dotfiles_fzf_git_fzf "$@" }
    fi
    _dotfiles_unbind_fzf_git_control_bindings
  fi
  unset _dotfiles_fzf_file _dotfiles_fzf_git _dotfiles_fzf_init
fi
