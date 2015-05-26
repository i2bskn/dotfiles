export LANG=ja_JP.UTF-8
export GREP_OPTIONS="--binary-files=without-match --color=auto"

which less > /dev/null 2>&1 && export PAGER=less
which vim > /dev/null 2>&1 && export EDITOR=vim
