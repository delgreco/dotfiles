# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# load user-specific profile, if present
if [ -f ~/.bash_profile.${USER} ]; then
    . ~/.bash_profile.${USER}
fi

