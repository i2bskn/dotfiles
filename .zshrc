# Perf
# zmodload zsh/zprof && zprof

# Keymap (viins)
bindkey -v

# History file and size
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Ignore duplicate history
setopt hist_ignore_all_dups
# Share history between processes
setopt share_history
# Ignore begin with a space
setopt hist_ignore_space
# Ignore function
setopt hist_no_functions
# Remove unnecessary space
setopt hist_reduce_blanks
# Ignore history command
setopt hist_no_store

# Depth of directory stack
DIRSTACKSIZE=30
# Change directory only path
setopt auto_cd
# Auto stack of source dir
# -<Tab>: Display candidates of direcctory stacks
setopt auto_pushd
# Ignore duplicate pushd
setopt pushd_ignore_dups
# To `$HOME` when no argments specified
setopt pushd_to_home
# Find home directory if not exist in current directory
cdpath=($HOME)

# Comments since `#` in command line
setopt interactive_comments

# 3 seconds or more consuming process displays information
REPORTTIME=3

# Complements {{{
autoload -U compinit
compinit -C

# Menu complements with tab barrage
setopt auto_menu
# List displayed if candidates is more than one
setopt auto_list
# Not display a new prompt foreach complements
setopt always_last_prompt
# Display candidates with small spacing
setopt list_packed
# Complements path after equals
setopt magic_equal_subst
# Add a slash to trailing when directory complements
setopt auto_param_slash
# Remove a slash from trailing when next charcter is delimiter
setopt auto_remove_slash
# No beep
setopt nolistbeep
# Add a type mark to trailing of filename
setopt list_types

# Case insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Selectable candidates
zstyle ':completion:*:default' menu select=2

# Complements by type of group
zstyle ':completion:*' format %F{226}'%d'%f
zstyle ':completion:*' group-name ''
# }}}

# Prompt {{{
autoload -Uz vcs_info

zstyle ':vcs_info:*' formats '%s->(%b)'

precmd() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  psvar[1]=$vcs_info_msg_0_
}

# Use escape sequence
setopt prompt_subst
function prompt_setup() {
  if [[ $TERM =~ ".*256color.*" ]]; then
    _prompt_colors=(
      "%F{124}"
      "%F{142}"
      "%F{27}"
      "%F{65}"
      "%F{66}"
    )
  else
    _prompt_colors=(
      "%F{red}"
      "%F{yellow}"
      "%F{green}"
      "%F{cyan}"
      "%F{cyan}"
    )
  fi

  local USER_HOST="${_prompt_colors[4]}%n@%m%f"
  local CURRENT_DIR="${_prompt_colors[5]}%~%f"
  local VCS_INFO="${_prompt_colors[3]}%1v%f"
  local RETCODE="[%(?.${_prompt_colors[3]}.${_prompt_colors[1]})%?%f]"
  local ARROWS="%B${_prompt_colors[1]}❯%f${_prompt_colors[2]}❯%f${_prompt_colors[3]}❯%f%b"

PROMPT="$USER_HOST $CURRENT_DIR $VCS_INFO
$RETCODE $ARROWS "
}

prompt_setup
# }}}

# aliases {{{
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
# }}}

# peco {{{
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
    local hosts=$(grep -iE "^host[[:space:]]+[^*]" ~/.ssh/config | awk '{print $2}' | sort | peco)

    if [ -n "$hosts" ]; then
      ssh $hosts
    fi
  }
  alias s="peco_select_ssh"

  alias -g P="| peco"
fi
# }}}

# env {{{
export LANG=ja_JP.UTF-8
export GREP_OPTIONS="--binary-files=without-match --color=auto"
which vim > /dev/null 2>&1 && export EDITOR=vim

if which less > /dev/null 2>&1; then
  export PAGER=less
  export LESS="--LONG-PROMPT -R --ignore-case"
fi
# }}}

# local settings
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

# zcompile {{{
if [ $HOME/.zshenv -nt $HOME/.zshenv.zwc ]; then
  zcompile $HOME/.zshenv
fi

if [ $HOME/.zshrc -nt $HOME/.zshrc.zwc ]; then
  zcompile $HOME/.zshrc
fi
# }}}

# Perf
# if (which zprof > /dev/null) ;then
#   zprof | less
# fi
