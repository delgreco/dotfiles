#!/bin/bash

# tmix - start a tmux session for a IX project

function create_tmux_session() {
    echo "Now creating tmux session '$dir'"
    tmux new -s $dir -d
    # tmux session best lives in app/
    echo "changing directory to 'app'"
    tmux send-keys -t $dir 'cd app' C-m
    #tmux rename-window -t $dir UI
    echo "opening Local/UI.pm in vim"
    tmux send-keys -t $dir 'vim Local/UI.pm' C-m
    echo "opening Local/Guts.pm in a vertical split"
    tmux send-keys -t $dir ':vsp Local/Guts.pm' C-m
    # the following didn't work; had to use vim config on CursorMoved event
    # echo "Equalizing size of vim panes"
    # tmux send-keys -t $dir ':windcmd =' C-m
    echo "creating new tmux window 'logs'"
    tmux new-window -t $dir -n logs
    echo "splitting into vertical panes"
    tmux splitw -h -t $dir
    echo "tailing logs"
    tmux send-keys -t $dir:2.1 "tail -f log/ssl_error.log" C-m
    tmux send-keys -t $dir:2.2 "tail -f log/error.log" C-m 
    echo "splitting right-hand pane (s)"
    tmux splitw -v -t $dir:2.2
    tmux send-keys -t $dir:2.3 "tail -f log/access.log" C-m
    echo "splitting lower right-hand pane"
    tmux splitw -v -t $dir:2.3
    tmux send-keys -t $dir:2.4 "sudo tail -f /var/log/maillog" C-m
    echo "creating new window 'cli'"
    tmux new-window -t $dir -n cli
    echo "splitting 'cli' window into vertical panes"
    tmux splitw -h -t $dir:3
    tmux send-keys -t $dir:3.1 "$dir-db" C-m
    if [ $hostname == 'orate.unh.edu' ]; then
        echo "Opening mail inboxes"
        tmux new-window -t $dir -n mail
        tmux splitw -h -t $dir    
        tmux send-keys -t $dir:4.1 'sudo su - autoproc' C-m
        tmux send-keys -t $dir:4.1 'mutt' C-m
        tmux send-keys -t $dir:4.2 'sudo su - dmca' C-m
        tmux send-keys -t $dir:4.2 'mutt' C-m
        tmux new-window -t $dir -n postgres
        tmux split-window -h -t $dir
        tmux send-keys -t $dir:5.1 'aruba' C-m
        tmux send-keys -t $dir:5.2 'aruba2' C-m
    else
        echo "No host-specific config"
    fi
    echo "Focusing on the 'vim' window"
    tmux select-window -t $dir:1
    # below gets: sessions should be nested with care, unset $TMUX to force
    # so, not sure how to proceed here yet
    #tmux attach -t $dir
}

sudo sleep 1

environment=$1
hostname=`hostname`
echo "hostname: $hostname"

if [[ -n "$environment" ]]; then
    dir=$environment
    echo "tmuxing '$dir' as specified"
    cd /var/www/apps/$environment
else
    # get the current working directory, absolute path
    path=$PWD;
    # get the name of the current directory
    # without the rest of the pathing.
    # we'll name the session after this.
    # so if $path is /var/www/apps/arm-dev
    # $dir becomes 'arm-dev'
    #dir=$path | grep -Eo '[^/]+/?$' | cut -d / -f1\
    dir=$(echo $path | grep -Eo '[^/]+/?$' | tr -d '\n')
    echo "tmuxing '$dir'"
fi
# we like to live in app/, this tests its existence
# as well as cd's into it
{ cd app; } >/dev/null 2>&1
if [[ $? -eq 0 ]]
then
    { tmux has-session -t "$dir"; } >/dev/null 2>&1
    if [[ $? -eq 0 ]]
    then
        echo "SORRY: tmux session '$dir' already exists." >&2        
        exit 1
    else
        echo "Creating tmux session '$dir'..."
        create_tmux_session
        exit 0
    fi
else
    echo "ERROR: No direcory called 'app' here.  This script assumes you are sitting in the top level of a IX project." >&2
    exit 1
fi



