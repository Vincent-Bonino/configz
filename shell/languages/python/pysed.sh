#! /usr/bin/env bash

# Massively edit Python files.
pysed() {
    local USAGE="usage: ${FUNCNAME[0]} ARGS...\nfind . -type f -name '*.py' -exec sed <args> '{}' \;"

    # Inspect arguments

    if [[ $1 == '-h' || $1 == '--help' ]]; then
        echo "$USAGE"
        return 0
    fi

    if [[ $# -eq 0 ]]; then
        &>2 echo "$USAGE"
        return 1
    fi

    # Be careful with git files, just in case
    if [[ -d ".git" ]]; then
        echo "Found '.git' directory, aborting"
        return 1
    fi

    echo "find . -type f -name '*.py' -exec sed $* '{}' \;"
    find . -type f -name '*.py' -exec sed "$@" '{}' \;
}


# Execute function if run directly
if ! (return &>/dev/null); then
    pysed "$@"
fi
