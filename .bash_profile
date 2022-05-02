# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

#PATH=$PATH:$HOME/bin:/usr/sbin:/usr/lib:/home/delgreco:/usr/local/bin:$HOME/perl5/perlbrew/bin
PATH=$HOME/.local/bin:/usr/local/bin:$PATH:/var/www/pbin/Perlbrew/bin
SVN_EDITOR=/usr/local/bin/vim

export EDITOR=/usr/local/bin/vim
export PATH
export SVN_EDITOR
unset USERNAME

HISTFILESIZE=
export TERM=xterm-256color

if [ -d /oraap/oracle/product/12.1.0/dbhome_1/lib ]; then
    export LD_LIBRARY_PATH=/oraapp/oracle/product/12.1.0/dbhome_1/lib
    export ORACLE_HOME=/oraapp/oracle/product/12.1.0/dbhome_1
else
    export ORACLE_HOME=/usr/lib/oracle/12.1/client64
    export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
fi

if test -f ~/.bash_aliases; then
    source ~/.bash_aliases
fi
if test -f ~/.mysql_aliases; then
    source ~/.mysql_aliases
fi
if test -f ~/.bash_aliases_; then
    source ~/.bash_aliases_
fi

#if test -f ~/perl5/perlbrew/etc/bashrc; then
#    source ~/perl5/perlbrew/etc/bashrc
#fi

#echo 'See all connected hosts: ss -napr'

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

alias please="sudo"

# for storing SVN passwords securely
export GPG_TTY=$(tty)
export GPG_AGENT_INFO=`gpgconf --list-dirs agent-socket | tr -d '\n' && echo -n ::`

