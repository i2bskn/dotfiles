if which peco &> /dev/null; then
  # History search
  function peco_select_history() {
    local tac
    (which gtac &> /dev/null && tac="gtac") || \
      (which tac &> /dev/null && tac="tac") || \
      tac="tail -r"
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle -R -c
  }
  zle -N peco_select_history
  bindkey '^r' peco_select_history

  # ghq
  if which ghq > /dev/null 2>&1; then
    function peco_select_src() {
      local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")

      if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
      fi
      zle clear-screen
    }
    zle -N peco_select_src
    bindkey '^]' peco_select_src
  fi

  function peco_select_branch() {
    local selected=$(git branch | grep -v '^*' | awk '{print $1}' | peco --query "$LBUFFER")

    if [ -n "$selected" ]; then
        git checkout $selected
    fi
  }
  zle -N peco_select_branch
  bindkey '^b' peco_select_branch

  # Issue of GitHub
  # see https://github.com/i2bskn/github-issues
  if which github-issues > /dev/null 2>&1; then
    function peco_select_issue() {
      local selected=$(github-issues | peco | awk '{print $2}')

      if [ -n "$selected" ]; then
        open $selected
      fi
    }
    alias i="peco_select_issue"
  fi

  # SSH
  function peco_select_ssh() {
    local hosts=$(grep -iE "^host[[:space:]]+[^*]" ~/.ssh/config | awk '{print $2}' | uniq | sort | peco)

    if [ -n "$hosts" ]; then
      ssh $hosts
    fi
  }
  alias s="peco_select_ssh"

  alias -g P="| peco"
fi
