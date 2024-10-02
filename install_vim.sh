#!/bin/bash

# install the latest vim

cd $HOME

# try to determine which kind of system we are on
YUM_CMD=$(which yum 2> /dev/null)
APT_GET_CMD=$(which apt-get 2> /dev/null)

if [[ ! -z $YUM_CMD ]]; then
    #sudo yum install gcc git ncurses-devel
    echo "yum packages required: gcc git ncurses-devel"
elif [[ ! -z $APT_GET_CMD ]]; then
    #sudo apt-get install build-essential libncurses-dev git
    echo "apt-get packages required: build-essential libncurses-dev git"
else
    echo "Neither yum nor apt-get are present on this system; dependencies may need to be installed manually"
fi

git clone https://github.com/vim/vim.git

cd vim/src

./configure --prefix=$HOME/.local && make && make install
