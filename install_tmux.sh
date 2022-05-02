#!/bin/bash

# Install tmux
# https://github.com/tmux/tmux/wiki/Installing

cd $HOME

# try to determine which kind of system we are on
YUM_CMD=$(which yum 2> /dev/null)
APT_GET_CMD=$(which apt-get 2> /dev/null)

if [[ ! -z $YUM_CMD ]]; then
    #sudo yum install gcc kernel-devel make ncurses-devel git
    echo "yum packages required: gcc kernel-devel make git"
elif [[ ! -z $APT_GET_CMD ]]; then
    #sudo apt-get install build-essential libncurses-dev git
    echo "apt-get packages required: build-essential git"
else
    echo "Neither yum nor apt-get are present on this system; some dependencies may need to be installed manually"
    exit 1;
fi

# install deps
mkdir -p $HOME/.local

# libevent
curl -OL https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz
tar -xvzf libevent-2.0.22-stable.tar.gz
cd libevent-2.0.22-stable
#./configure --prefix=/usr/local
#./configure --prefix=$HOME/.local --enable-shared
./configure --prefix=$HOME/.local
make -j && make install

cd ..

# ncurses
NCURSES_VERSION="6.2"
curl -OL https://ftp.gnu.org/pub/ncurses/ncurses-${NCURSES_VERSION}.tar.gz
tar -xvzf ncurses-${NCURSES_VERSION}.tar.gz
cd ncurses-${NCURSES_VERSION}
./configure --prefix=$HOME/.local
make -j && make install

cd ..

# tmux
TMUX_VERSION="3.2a"
curl -OL https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
tar -xvzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
#LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
#PKG_CONFIG_PATH=$HOME/.local/lib/pkgconfig ./configure --prefix=$HOME/.local
./configure --prefix=$HOME/.local CPPFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncurses" LDFLAGS="-L$HOME/.local/lib"
make -j && make install

cd ..

# pkill tmux
# close your terminal window (flushes cached tmux executable)
# open new shell and check tmux version
tmux -V


