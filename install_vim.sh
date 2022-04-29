#!/bin/bash

# install the latest vim

cd $HOME

# try to determine which kind of system we are on
YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)

if [[ ! -z $YUM_CMD ]]; then
    sudo yum install gcc git ncurses-devel
elif [[ ! -z $APT_GET_CMD ]]; then
    sudo apt-get install build-essential libncurses-dev git
else
    echo "Neither yum nor apt-get are present on this system; dependencies may need to be installed manually"
    exit 1;
fi

git clone https://github.com/vim/vim.git

cd vim/src

sudo make

sudo make install
