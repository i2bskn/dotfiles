alias g="git"
alias v="vim"
alias t="tmux"
alias ta="tmux a"
alias tl="tmux ls"

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -pi"
alias mkdir="mkdir -p"

which less > /dev/null 2>&1 && alias -g L="| less"
which ag > /dev/null 2>&1 && alias -g A="| ag"

case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -G"
  ;;
linux*)
  alias ls="ls --color"
  ;;
esac

if which java > /dev/null 2>&1; then
  alias javac="javac -J-Dfile.encoding=UTF-8"
  alias java="java -Dfile.encoding=UTF-8"
fi

