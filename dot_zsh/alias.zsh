alias g="git"
alias v="nvim"

alias mkdir="mkdir -p"

alias cot="open -a CotEditor"

if which eza > /dev/null 2>&1; then
  alias ls="eza --icons --group-directories-first"
  alias ll="eza -ahl --icons --group-directories-first --git"
  alias lt="eza --tree --icons"
fi

