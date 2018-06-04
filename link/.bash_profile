# ~/.bash_profile: executed by bash(1) when starting a login shell.

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -f ~/.bash_profile.local ]; then
    . ~/.bash_profile.local
fi
