#!/bin/bash

# Install tmux and vim on rhel/centos 7
# Run the Perl installation script to setup developmemnt environment

cd $HOME

dotfiles/install_tmux.sh
dotfiles/install_vim.sh
dotfiles/linkFiles.pl

