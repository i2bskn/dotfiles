# Keybind (Vim)
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
# Remove unnecessary space
setopt hist_reduce_blanks
# Ignore history command
setopt hist_no_store

# Change directory only path
setopt auto_cd
# Auto stack of source dir
# -<Tab>: Display candidates of direcctory stacks
setopt auto_pushd
# Ignore duplicate pushd
setopt pushd_ignore_dups
# Find home directory if not exist in current directory
cdpath=($HOME)

# Comments since `#` in command line
setopt interactive_comments

# 3 seconds or more consuming process displays information
REPORTTIME=3

# Complements {{{
autoload -U compinit
compinit

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

umask 022

# zsh-completions
if [ -d /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

# extensions
if [ -d $HOME/.zsh ]; then
  for ext in $HOME/.zsh/*.zsh; do
    source $ext
  done
fi

# local settings
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

