# ~/.bash_profile: executed by bash(1) when starting a login shell.

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi


if [ -d '/Users/lucian/.sdkman' ]; then
    export SDKMAN_DIR='/Users/lucian/.sdkman'
    [[ -s '/Users/lucian/.sdkman/bin/sdkman-init.sh' ]] && source '/Users/lucian/.sdkman/bin/sdkman-init.sh'
fi
