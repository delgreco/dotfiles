# explicitly enable aliases
shopt -s expand_aliases  

alias cron='sudo crontab -l -u'
#alias deploy.pl='/usr/bin/script -a deploy.txt -c deploy.pl'
alias ixk='sudo /usr/local/bin/ixctl kill'
alias ixkt='sudo /usr/local/bin/ixctl killthis'
#alias ix_changes='for i in `/usr/bin/ls /var/www/apps/`; do cd /var/www/apps/$i/app/IX; svn st | grep -ve "^$" | grep -v Performing | grep -v "X "; done'
alias ix_changes='/usr/local/bin/release/ix_changes.sh'
alias point='svn propset svn:externals -F svn.externals .'
alias pointup='svn propset svn:externals -F svn.externals .; svn up;'
alias pu='pointup'
alias psmew='watch psme'
alias restart='sudo apachectl restart'
alias space='sudo du -hsx * | sort -rh | head -10'
alias ssl_weblog='sudo vim /etc/httpd/logs/ssl_error_log'
alias supergrep='LC_ALL=C fgrep -A 50 -B 50'
alias svnl='svnl.pl';
alias ulazy='sudo umount -f -a -t cifs -l'
alias tmix='~/dotfiles/tmix.sh'
alias v='vim'
alias weblog='sudo vim /etc/httpd/logs/error_log'

function svndiff() {
    svn diff $1 | vim -
}
