################################################################################
# The .bashrc file of Lucian Pestritu
# Based largely on the default .bashrc file that comes with Ubuntu 12.04.
# Check http://github.com/lucianp/dotfiles for the latest version.
#
# Remember the startup files execution sequence:
# Interactive login shell:
#   source /etc/profile
#   source first that exists: ~/.bash_profile, ~/.bash_login or ~/.profile
# When exiting an interactive login shell:
#   source ~/.bash_logout
# Interactive non-login shell:
#   source ~/.bashrc
# See man 1 bash for more details or visit:
# http://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html
################################################################################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=
HISTFILESIZE=

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \W\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

[ -d '/usr/local/etc/bash_completion.d' ] && export BASH_COMPLETION_COMPAT_DIR='/usr/local/etc/bash_completion.d'
[ -r '/usr/local/etc/profile.d/bash_completion.sh' ] && . '/usr/local/etc/profile.d/bash_completion.sh'
[ -r '/opt/homebrew/etc/profile.d/bash_completion.sh' ] && . '/opt/homebrew/etc/profile.d/bash_completion.sh'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Get rid of bash deprecation message on Mac OS X Catalina (https://support.apple.com/kb/HT208050)
export BASH_SILENCE_DEPRECATION_WARNING=1

export LANG='en_US.UTF-8'

# vi mode should be enabled via .inputrc
# keeping these lines commented out for future reference
#set -o vi
#bind -m vi-insert '"jj": vi-movement-mode'
#bind -m vi-insert 'Control-l: clear-screen'

# brew environment setup (obtained by executing /opt/homebrew/bin/brew shellenv)
if [ -d "/opt/homebrew" ]; then
    export HOMEBREW_PREFIX="/opt/homebrew";
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

    # Set GNU grep as "default"
    if [ -d "/opt/homebrew/opt/grep/libexec/gnubin" ]; then
        PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
    fi

    # Set GNU sed as "default"
    if [ -d "/opt/homebrew/opt/gnu-sed/libexec/gnubin" ]; then
        PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
    fi
fi

# sdkman environment setup
if [ -d "$HOME/.sdkman" ]; then
    export SDKMAN_DIR="$HOME/.sdkman"
    [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# Oracle setup
if [ -d "$HOME/tnsadmin" ]; then
    export TNS_ADMIN="$HOME/tnsadmin"
fi

