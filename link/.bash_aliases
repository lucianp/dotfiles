################################################################################
# Interactive Bash aliases and utility functions.
# This file is normally sourced by ~/.bashrc.
# See https://github.com/lucianp/dotfiles for the latest version.
################################################################################

# File listing aliases
# -C force multi-column format
# -F append file type indicator
# -A list all entries except . and ..
# -l list in long format
# -h list file sizes in human-readable format
# -t sort by descending time modified (most recently modified first)
# -r reverse the order of the sort
alias l='ls -CF'
alias la='l -A'
alias ll='ls -hAlF'
alias lt='ls -hAlFrt'

# Date and time helpers
alias day='date +%Y-%m-%d'
alias week='date +%V'
alias isodate='date +%Y-%m-%dT%Hh%M%Z | printcopy'

days-ago() {
    local num_days_ago
    local format

    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        printf 'Usage: days-ago <number-of-days> [format]\n' >&2
        return 1
    fi

    num_days_ago=$1
    format=${2:-+%Y-%m-%d}

    case $num_days_ago in
        '' | *[!0-9+-]* | + | -)
            printf 'Error: number of days must be an integer\n' >&2
            return 1
            ;;
    esac

    if date -d '1970-01-01' '+%Y' >/dev/null 2>&1; then
        date -d "$num_days_ago days ago" "$format"
    else
        date -v "$((-num_days_ago))d" "$format"
    fi
}

# Opens the current directory in the system file explorer. Override
# FILE_EXPLORER_COMMAND on other platforms, for example:
#   Linux: export FILE_EXPLORER_COMMAND='xdg-open .'
#   WSL:   export FILE_EXPLORER_COMMAND='explorer.exe .'
explore() {
    sh -c "${FILE_EXPLORER_COMMAND:-open .}"
}

# Copies stdin to the system clipboard. Override CLIPBOARD_COPY_COMMAND to use
# another command, such as 'wl-copy' or 'xclip -selection clipboard'.
clipboard-copy() {
    sh -c "${CLIPBOARD_COPY_COMMAND:-pbcopy}"
}

# Prints a visible marker for separating large blocks of terminal output.
mark() {
    printf '%80s\n' '' | tr ' ' '='
    printf '%37sMARKER%37s\n' '' '' | tr ' ' '='
    printf '%80s\n' '' | tr ' ' '='
}

# Prints stdin and copies it to the clipboard. By default, printed output is
# guaranteed to end with a newline, while one trailing newline is omitted
# from the clipboard content. Use -p to preserve stdin exactly.
printcopy() {
    local preserve=0
    local input
    local clipboard
    local newline='
'

    case ${1-} in
        -p)
            preserve=1
            shift
            ;;
        -*)
            printf 'Error: unknown option: %s\n' "$1" >&2
            printf 'Usage: printcopy [-p]\n' >&2
            return 1
            ;;
    esac

    if [ "$#" -ne 0 ]; then
        printf 'Usage: printcopy [-p]\n' >&2
        return 1
    fi

    # Append a sentinel so command substitution does not strip trailing newlines.
    # `&&` ensures the sentinel is appended only if stdin was read successfully.
    if ! input=$(cat && printf x); then
        printf 'Error: could not read standard input\n' >&2
        return 1
    fi
    input=${input%x}

    if [ "$preserve" -eq 1 ]; then
        printf '%s' "$input"
        printf '%s' "$input" | clipboard-copy
        return
    fi

    case $input in
        *"$newline")
            printf '%s' "$input"
            clipboard=${input%"$newline"}
            ;;
        *)
            printf '%s\n' "$input"
            clipboard=$input
            ;;
    esac

    printf '%s' "$clipboard" | clipboard-copy
}

# Copies a minimal interactive Bash configuration to the clipboard.
quick-shell-config() {
    printf '%s\n' \
        "alias ll='ls -hAlF'" \
        "alias lt='ls -hAlFrt'" \
        'set -o vi' \
        'bind -m vi-insert "\"jj\": vi-movement-mode"' \
        "bind -m vi-insert 'Control-l: clear-screen'" |
        clipboard-copy
}

# Prints the image tag used by the first container of a Kubernetes deployment.
k-deploy-ver() {
    if [ "$#" -ne 1 ]; then
        printf 'Error: deployment name is required.\n' >&2
        printf 'Usage: k-deploy-ver <deployment-name>\n' >&2
        return 1
    fi

    kubectl get deployment "$1" \
        -o jsonpath='{.spec.template.spec.containers[0].image}' |
        sed 's/.*://'

    printf '\n'
}

# Configure kubectl bash completion, which otherwise gets loaded lazily.
# Also configure the abbreviated k alias.
if command -v kubectl >/dev/null 2>&1; then
    if [ -n "${BASH_COMPLETION_USER_DIR:-}" ]; then
        _kubectl_completion_dir="$BASH_COMPLETION_USER_DIR/completions"
    else
        _kubectl_completion_dir="${XDG_DATA_HOME:-"$HOME/.local/share"}/bash-completion/completions"
    fi

    _kubectl_completion_file="$_kubectl_completion_dir/kubectl"

    # Load an existing completion definition when available.
    if ! complete -p kubectl >/dev/null 2>&1; then
        # Generate and cache the completion script if it is missing or empty.
        if [ ! -s "$_kubectl_completion_file" ]; then
            if mkdir -p "$_kubectl_completion_dir"; then
                _kubectl_completion_tmp="$_kubectl_completion_file.tmp.$$"

                if kubectl completion bash >"$_kubectl_completion_tmp"; then
                    mv "$_kubectl_completion_tmp" "$_kubectl_completion_file"
                else
                    rm -f "$_kubectl_completion_tmp"
                fi
            fi
        fi

        # Load the cached completion script.
        if [ -s "$_kubectl_completion_file" ]; then
            . "$_kubectl_completion_file"
        fi
    fi

    alias k='kubectl'

    # Apply kubectl's completion function to the alias.
    if declare -F __start_kubectl >/dev/null 2>&1; then
        complete -o default -F __start_kubectl k
    fi

    unset _kubectl_completion_dir
    unset _kubectl_completion_file
    unset _kubectl_completion_tmp
fi


# Load machine-specific aliases and overrides, when present.
if [ -f "$HOME/.bash_aliases.local" ]; then
    . "$HOME/.bash_aliases.local"
fi

