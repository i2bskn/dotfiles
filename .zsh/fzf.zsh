if which fzf > /dev/null 2>&1; then
  # Default Options
  # --reverse: 上から下に表示
  # --border: 枠線
  # --height: 画面を占有しすぎない
  export FZF_DEFAULT_OPTS='--reverse --border --height 40% --color=bg+:#292e42,hl:#bb9af7,fg:#c0caf5,hl+:#7dcfff,info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff,marker:#9ece6a,spinner:#9ece6a,header:#9ece6a'

  # Default Commands
  # --files: ファイル一覧を表示
  # --hidden: 隠しファイルも含める
  # --glob: .gitディレクトリだけは確実に除外する
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  # History search (Ctrl + r)
  source <(fzf --zsh)

  # ghq (Ctrl + ])
  function fzf_select_src() {
    local selected_dir=$(ghq list --full-path | fzf --query "$LBUFFER" \
      --preview 'ls -C {} | head -200')

    if [ -n "$selected_dir" ]; then
      BUFFER="cd ${selected_dir}"
      zle accept-line
    fi
    zle clear-screen
  }
  zle -N fzf_select_src
  bindkey '^]' fzf_select_src

  # SSH (alias: s)
  function fzf_select_ssh() {
    local hosts=$(grep -iE "^host[[:space:]]+[^*]" ~/.ssh/config ~/.ssh/config.d/* 2>/dev/null | awk '{print $2}' | uniq | sort | fzf)
    if [ -n "$hosts" ]; then
      ssh $hosts
    fi
  }
  alias s="fzf_select_ssh"

  # GitHub Issues (alias: i)
  if which gh > /dev/null 2>&1; then
    function fzf_select_gh_issue() {
      # 自分のIssueを一覧表示して fzf で選択、ブラウザで開く
      local selected=$(gh issue list --limit 100 | fzf --reverse --height 40% --header "Select Issue")
      if [ -n "$selected" ]; then
        local issue_number=$(echo $selected | awk '{print $1}')
        gh issue view --web $issue_number
      fi
    }
    alias i="fzf_select_gh_issue"
  fi

  # Aliases
  alias -g F="| fzf"
  alias -g B="\`git branch | fzf | sed -e \"s/^[\* ]*//g\"\`"
  if which docker > /dev/null 2>&1; then
    alias -g D="\`docker ps --format '{{.Names}}' | fzf\`"
  fi
fi

