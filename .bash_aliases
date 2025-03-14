# explicitly enable aliases in Bash,
# whereas zsh expands them automatically
if [ -n "$BASH_VERSION" ]; then
    shopt -s expand_aliases
fi

# general / Apache / cron / vim / Postrgres
alias cron='sudo crontab -l -u'
alias restart='sudo apachectl restart'
alias space='sudo du -hsx * | sort -rh | head -10'
alias weblog='sudo vim /etc/httpd/logs/error_log'
alias ssl_weblog='sudo vim /etc/httpd/logs/ssl_error_log'
alias supergrep='LC_ALL=C fgrep -A 50 -B 50'
alias ulazy='sudo umount -f -a -t cifs -l'
alias v='vim'
alias pg='sudo -u postgres psql'
alias venv="source venv/bin/activate"

# IX and Subversion
alias ixk='sudo /usr/local/bin/ixctl kill'
alias ixkt='sudo /usr/local/bin/ixctl killthis'
alias ix_changes='/usr/local/bin/release/ix_changes.sh'
alias ext='/usr/local/bin/release/externals.pl'
alias point='svn propset svn:externals -F svn.externals .'
alias pointup='svn propset svn:externals -F svn.externals .; svn up;'
alias pu='pointup'
alias psmew='watch psme'
alias svnl='svnl.pl';
alias tmix='~/dotfiles/tmix.sh'

function svndiff() {
    svn diff $1 | vim -
}

function gitdiff() {
    git diff $1 | vim -
}

