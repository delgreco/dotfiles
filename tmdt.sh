#!/bin/bash

# tmix - start a tmux session for DeepThought work

function create_tmux_session() {
    tmux new -s $env -d
    # tmux session best lives in ~/deepthought
    echo "changing directory to '~/deepthought'"
    tmux send-keys -t $env 'cd ~/deepthought' C-m
    #tmux rename-window -t $env UI
    echo "opening chatbot/cron/topicalize.py in vim"
    tmux send-keys -t $env 'vim chatbot/cron/topicalize.py' C-m
    # echo "opening Local/Guts.pm in a vertical split"
    # tmux send-keys -t $env ':vsp Local/Guts.pm' C-m
    tmux set-environment -g PGPASSWORD "$PGPASSWORD"
    tmux set-environment -g PGUSER "$PGUSER"
    tmux set-environment -g PGHOST "$PGHOST"
    tmux set-environment -g PGPORT "$PGPORT"
    tmux set-environment -g PGDATABASE "$PGDATABASE"

    echo "creating new window 'pg'"
    tmux new-window -t $env -n pg
    # echo "splitting 'cli' window into vertical panes"
    tmux splitw -h -t $env:2
    tmux send-keys -t $env:2.1 "psql" C-m

    echo "creating new window 'cli'"
    tmux new-window -t $env -n cli
    echo "splitting 'cli' window into vertical panes"
    tmux splitw -h -t $env:3

    echo "Focusing on the 'vim' window"
    tmux select-window -t $env:1
}

sleep 1

source ~/.pg_env

env='deepthought'
hostname=`hostname`
echo "hostname: $hostname"

{ tmux has-session -t "$env"; } >/dev/null 2>&1
if [[ $? -eq 0 ]]
then
    echo "SORRY: tmux session '$env' already exists." >&2        
    exit 1
else
    echo "Creating tmux session '$env'..."
    create_tmux_session
    exit 0
fi


