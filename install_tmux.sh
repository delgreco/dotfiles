#!/bin/bash

# Install tmux

cd $HOME

# try to determine which kind of system we are on
YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)

if [[ ! -z $YUM_CMD ]]; then
    sudo yum install gcc kernel-devel make ncurses-devel git
elif [[ ! -z $APT_GET_CMD ]]; then
    sudo apt-get install build-essential libncurses-dev git
else
    echo "Neither yum nor apt-get are present on this system; dependencies may need to be installed manually"
    exit 1;
fi

# install deps

# DOWNLOAD SOURCES FOR LIBEVENT AND MAKE AND INSTALL
curl -OL https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz
tar -xvzf libevent-2.0.22-stable.tar.gz
cd libevent-2.0.22-stable
./configure --prefix=/usr/local
make
sudo make install
cd ..

# DOWNLOAD SOURCES FOR TMUX AND MAKE AND INSTALL
TMUX_VERSION="3.2a"
curl -OL https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
tar -xvzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
make
sudo make install
cd ..

# pkill tmux
# close your terminal window (flushes cached tmux executable)
# open new shell and check tmux version
tmux -V


