#!/bin/bash

# install the latest vim on Red Hat EL7

cd $HOME

sudo yum install gcc git ncurses-devel

git clone https://github.com/vim/vim.git

cd vim/src

sudo make

sudo make install
