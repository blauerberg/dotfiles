if [[ "$OSTYPE" == darwin* ]]; then
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

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

if [[ -o zle && -t 0 ]] && command -v fzf >/dev/null 2>&1; then
  if _dotfiles_fzf_init=$(fzf --zsh 2>/dev/null); then
    eval "$_dotfiles_fzf_init"
  else
    for _dotfiles_fzf_file in \
      /usr/share/doc/fzf/examples/key-bindings.zsh \
      /usr/share/fzf/key-bindings.zsh \
      /opt/homebrew/opt/fzf/shell/key-bindings.zsh \
      /usr/local/opt/fzf/shell/key-bindings.zsh
    do
      if [[ -r "$_dotfiles_fzf_file" ]]; then
        source "$_dotfiles_fzf_file"
        break
      fi
    done
  fi
  unset _dotfiles_fzf_file _dotfiles_fzf_init
fi

if command -v aws_completer >/dev/null 2>&1; then
  autoload -Uz bashcompinit
  bashcompinit
  complete -C "$(command -v aws_completer)" aws
fi

if command -v gcloud >/dev/null 2>&1; then
  for _dotfiles_gcloud_completion in \
    "$HOME/google-cloud-sdk/completion.zsh.inc" \
    /usr/share/google-cloud-sdk/completion.zsh.inc \
    /opt/homebrew/share/google-cloud-sdk/completion.zsh.inc \
    /usr/local/share/google-cloud-sdk/completion.zsh.inc
  do
    if [[ -r "$_dotfiles_gcloud_completion" ]]; then
      source "$_dotfiles_gcloud_completion"
      break
    fi
  done
  unset _dotfiles_gcloud_completion
fi

export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-ap-northeast-1}"
export CLAUDE_CODE_NO_FLICKER="${CLAUDE_CODE_NO_FLICKER:-1}"
