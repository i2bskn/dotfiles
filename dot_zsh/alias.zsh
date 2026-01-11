alias g="git"
alias v="nvim"

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -pi"
alias mkdir="mkdir -p"

if which eza > /dev/null 2>&1; then
  alias ls="eza --icons --group-directories-first"
  alias ll="eza -ahl --icons --group-directories-first --git"
  alias lt="eza --tree --icons"
fi

