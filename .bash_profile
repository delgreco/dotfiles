# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# load user-specific profile, if present
if [ -f ~/.bash_profile.${USER} ]; then
    . ~/.bash_profile.${USER}
fi

# make sure we have
# rw-rw-r--
umask 002

# NOTE: we seemed to need this and then suddenly we seemed not to need it.  Huh??
# we'll keep it around awhile in case tmux breaks again.
# load .env file
# if [[ -f .env ]]; then
#     source .env
# fi
# an AD-based username has an @ in it..., which makes tmux
# fail to locate its .tmux.conf file, so explicitly
# exporting $HOME seems to work.
# if [[ "$HOSTNAME" == "$AD_BOUND_HOSTNAME" ]]; then
#     export HOME="/home/$USER"
# fi

# append import paths to $PATH 
PATH=$HOME/.local/bin:/usr/local/bin:$PATH:/var/www/pbin/Perlbrew/bin

# set vim as the editor for SVN
SVN_EDITOR=$(which vim 2> /dev/null)

# let tmux know where libevent libraries are
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/libevent-2.1.12-stable/.libs
export EDITOR=$(which vim 2> /dev/null)
export PATH
export SVN_EDITOR

unset USERNAME

HISTFILESIZE=
export TERM=xterm-256color

# bash aliases included in dotfiles
if test -f ~/.bash_aliases; then
    source ~/.bash_aliases
fi

# bash aliases for mysql connections not included in dotfiles
if test -f ~/.mysql_aliases; then
    source ~/.mysql_aliases
fi

# additional bash aliases not included in dotfiles
if test -f ~/.bash_aliases_; then
    source ~/.bash_aliases_
fi

#echo 'See all connected hosts: ss -napr'

# customize command prompt with colors
# user@host [curdir]:
export PS1="\[\e[1;31m\]\u\[\e[0m\]@\[\e[0;36m\]\h \[\e[0m\]\[\e[m\[\e[0;32m\][\W]\[\e[0m\]: "

export HISTSIZE=10000

# colored man pages
man() { env \
  LESS_TERMCAP_mb=$'\e[01;31m' \
  LESS_TERMCAP_md=$'\e[01;31m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[01;33m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[01;32m' \
  man "$@"
}

# colored ls output
alias ls='ls --color'

# attach to last tmux session, or start a new session
# if no session exists
if [ -z "$TMUX" ]; then
    tmux a -d || tmux new -s new
fi

# for storing SVN passwords securely
export GPG_TTY=$(tty)
# test for gpgconf to avoid erorr if missing
if command -v gpgconf &> /dev/null
then
    export GPG_AGENT_INFO=`gpgconf --list-dirs agent-socket | tr -d '\n' && echo -n ::`
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

