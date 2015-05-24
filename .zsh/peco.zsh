if which peco &> /dev/null; then
  # History search
  function peco_select_history() {
    local tac
    (which gtac &> /dev/null && tac="gtac") || \
      (which tac &> /dev/null && tac="tac") || \
      tac="tail -r"
    BUFFER=$(fc -l -n 1 | eval $tac | \
      peco layout=bottom-up --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle -R -c
  }
  zle -N peco_select_history
  bindkey '^r' peco_select_history

  # SSH
  function peco_select_ssh() {
    local hosts=$(grep -iE "^host[[:space:]]+[^*]" ~/.ssh/config|awk '{print $2}'|sort|peco)

    if [ -n "$hosts" ]; then
      ssh $hosts
    fi
  }
  alias s="peco_select_ssh"

  # Modified file open in git repository
  function peco_select_open_modified_file() {
    # Error when execute outside repository.
    local files=$(git status --short | awk '{print $2}' | peco)

    if [ -n "$files" ]; then
      eval "$EDITOR $files"
    fi
  }
  alias mod="peco_select_open_modified_file"

  # Change directory to ruby gem
  function peco_select_cd_gems() {
    local available_cmd='Bundler::SharedHelpers.send(:find_gemfile)'
    local gemslist_cmd='Bundler.load.specs.sort_by{|s|s.name}.each{|s|puts s.full_gem_path}'
    local gem=$(ruby -r bundler -e "$available_cmd && $gemslist_cmd" | peco)

    if [ -n "$gem" ]; then
      cd $gem
    fi
  }
  alias gems="peco_select_cd_gems"

  function peco_select_repos() {
    local repo=$(ghq list --full-path | peco)

    if [ -n "$repo" ]; then
      cd $repo
    fi
  }
  alias repos="peco_select_repos"

  alias -g P="| peco"
fi

