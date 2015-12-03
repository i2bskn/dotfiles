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
