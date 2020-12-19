#!/bin/bash

# Install tmux and vim on rhel/centos 7
# Run the Perl installation script to setup developmemnt environment

cd $HOME

dotfiles/tmux_install.sh
dotfiles/vim_install.sh
dotfiles/install.pl

