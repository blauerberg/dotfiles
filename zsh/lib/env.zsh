setopt interactivecomments
setopt nonomatch
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

export HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
export HISTSIZE="${HISTSIZE:-10000}"
export SAVEHIST="${SAVEHIST:-10000}"
export HISTORY_IGNORE="${HISTORY_IGNORE:-"(cd|pwd|exit|l[sal]|ls -*)"}"

typeset -U path PATH

for dir in \
  "$HOME/.local/bin" \
  "$HOME/.devcontainers/bin" \
  "$HOME/.docker/bin" \
  /opt/homebrew/bin \
  /usr/local/bin \
  /opt/homebrew/opt/coreutils/libexec/gnubin
do
  if [[ -d "$dir" ]]; then
    path=("$dir" $path)
  fi
done

alias sshp="ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no"
alias dc="docker compose"

if command ls --color=auto / >/dev/null 2>&1; then
  alias ls="ls --color=auto"
fi

if [[ "$OSTYPE" == linux* ]] && command -v nvim >/dev/null 2>&1; then
  alias vi="nvim"
fi
