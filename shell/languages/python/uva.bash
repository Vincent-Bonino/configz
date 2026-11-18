#! /usr/bin/env bash

# Activate any registered UV virtual environment from its name.
#
# Note that UV_ACTIVE will only be unset if sourced.

declare -A virtual_envs=(
    # == Keys below ==
)

uva() {
    if [[ $# -ne 1 || $1 == '-h' || $1 == '--help' ]]; then
        echo "Usage:"
        echo "$0 name"
        exit
    fi

    venv_activation_path=${virtual_envs[$1]}

    if [[ -z $venv_activation_path ]]; then
        echo "Unknown virtual env. named '$1'"
        exit 1
    fi

    source "$venv_activation_path"
    export UV_ACTIVE=1
}

# Execute function if run directly
if ! (return &>/dev/null); then
    uva "$@"
fi

