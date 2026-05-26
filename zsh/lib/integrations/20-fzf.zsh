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
  fi
  unset _dotfiles_fzf_file _dotfiles_fzf_git _dotfiles_fzf_init
fi
