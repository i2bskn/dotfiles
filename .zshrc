# Perf
# zmodload zsh/zprof && zprof

# Not output coredump
limit coredumpsize 0

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

# complements {{{
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

# aliases {{{
alias g="git"
alias v="vim"

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -pi"
alias mkdir="mkdir -p"

alias activate="source .venv/bin/activate"

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

# env {{{
typeset -U path fpath

# rbenv
if [ -e $HOME/.rbenv ]; then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

# nodeenv
if [ -e $HOME/.nodenv ]; then
  export PATH=$HOME/.nodenv/bin:$PATH
  eval "$(nodenv init -)"
fi

if [ -e $HOME/.pyenv ]; then
  export PYENV_ROOT=$HOME/.pyenv
  export PATH=$PYENV_ROOT/bin:$PATH
  eval "$(pyenv init -)"
fi

# golang
if which go > /dev/null; then
  export GOPATH=$HOME/dev
  export PATH=$PATH:$GOPATH/bin
  export GO111MODULE=on
fi

# zsh-completions
if [ -d /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

# direnv
if which direnv > /dev/null; then
  eval "$(direnv hook zsh)"
fi

# OpenSSL
if [ -d /usr/local/opt/openssl ]; then
  export PATH="/usr/local/opt/openssl/bin:$PATH"
  export LDFLAGS="-L/usr/local/opt/openssl/lib"
  export CPPFLAGS="-I/usr/local/opt/openssl/include"
  export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
fi

# Utilities
[ -d $HOME/.local/bin ] && export PATH=$PATH:$HOME/.local/bin

export LANG=ja_JP.UTF-8
export GREP_OPTIONS="--binary-files=without-match --color=auto"
export XDG_CONFIG_HOME=$HOME/.config
which vim > /dev/null 2>&1 && export EDITOR=vim

if which less > /dev/null 2>&1; then
  export PAGER=less
  export LESS="--LONG-PROMPT -R --ignore-case"
fi
# }}}

# extensions and compile {{{
function compile() {
  src=$1
  if [ -e ${src}.zwc ]; then
    if [ ${src} -nt ${src}.zwc ]; then
      zcompile ${src}
    fi
  else
    zcompile ${src}
  fi
}

for src in $(ls $HOME/.zsh/*.zsh); do
  source $src
  compile $src
done

compile $HOME/.zshrc
# }}}

# local settings
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

# Perf
# if (which zprof > /dev/null) ;then
#   zprof | less
# fi
