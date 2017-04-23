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

  case "${OSTYPE}" in
  darwin*)
    # Issue of GitHub
    # see https://github.com/i2bskn/github-issues
    if which github-issues > /dev/null 2>&1; then
      function peco_select_issue() {
        if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
          local selected=$(github-issues -current | peco | awk '{print $2}')
        else
          local selected=$(github-issues -self | peco | awk '{print $2}')
        fi

        if [ -n "$selected" ]; then
          open -a "/Applications/Google Chrome.app" $selected
        fi
      }
      alias i="peco_select_issue"
    fi
  esac

  # SSH
  function peco_select_ssh() {
    local hosts=$(grep -iE "^host[[:space:]]+[^*]" ~/.ssh/config ~/.ssh/config.d/* | awk '{print $2}' | uniq | sort | peco)

    if [ -n "$hosts" ]; then
      ssh $hosts
    fi
  }
  alias s="peco_select_ssh"

  # Aliases
  alias -g P="| peco"
  alias -g B="\`git branch | peco | sed -e \"s/^[\* ]*//g\"\`"
  if which docker > /dev/null 2>&1; then
    alias -g D="\`docker ps --format '{{.Names}}' | peco\`"
  fi
fi
