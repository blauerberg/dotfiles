alias sshp="ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no"
alias dc="docker compose"

if command ls --color=auto / >/dev/null 2>&1; then
  alias ls="ls --color=auto"
fi

if command -v nvim >/dev/null 2>&1; then
  alias vi="nvim"
fi
