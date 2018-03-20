################################################################################
# The .bash_aliases file of Lucian Pestritu
# ~/.bash_aliases is usually sourced by ~/.bashrc.
# Check http://github.com/lucianp/dotfiles for the latest version.
################################################################################

### ls aliases (progressive)
# -C force multi-column format
# -F append file type indicator
# -A list all entries except . and ..
# -l list in long format
# -h list file sizes in human readable format
alias l='ls -CF'
alias la='l -A'
alias ll='ls -hAlF'

### date aliases
alias day='date +%Y-%m-%d'
alias week='date +%V'
alias isodate='date +%Y-%m-%dT%H.%M%Z'
gnu-days-ago() {
    date -d "$1 days ago" '+%Y-%m-%d'
}
mac-days-ago() {
    date -v -$1d '+%Y-%m-%d'
}

### clear aliases
alias cl='clear'
alias cls='clear;l'
alias cll='clear;ll'
alias mark='perl -E "\$s=q{=}; say \$s x 80; say \$s x 37 . q{MARKER} . \$s x 37; say \$s x 80"'
alias clm='cl;mark'

### platform-specific aliases
unamestr="$(uname)"
if [[ "$unamestr" == *[Dd]arwin* ]]; then
    alias explore='open "$(pwd)"'
    alias days-ago='mac-days-ago'
elif [[ "$unamestr" == *[Ll]inux* ]]; then
    alias explore='nautilus "$(pwd)"'
    alias days-ago='gnu-days-ago'
fi
unset unamestr

### local alias definitions
if [ -f ~/.bash_aliases.local ]; then
    . ~/.bash_aliases.local
fi

