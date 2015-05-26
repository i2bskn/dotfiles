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
    bindkey '^p' peco_select_src
  fi

  # SSH
  function peco_select_ssh() {
    local hosts=$(grep -iE "^host[[:space:]]+[^*]" ~/.ssh/config | awk '{print $2}' | sort | peco)

    if [ -n "$hosts" ]; then
      ssh $hosts
    fi
  }
  alias s="peco_select_ssh"

  alias -g P="| peco"
fi
