#! /usr/bin/env bash

# Create a new Python virtual environment.
# Supports pyenv's plugin `virtualenv` and `uv`.

# Create a new Python virtual environment.
#
# Parameters:
#   1. Virtual environment manager. (virtualenv|uv)
#   2. Python version of the environment.
#   3. Name if the environment.
pyvenv() {
    local USAGE="usage: ${FUNCNAME[0]} virtualenv|uv VERSION NAME [EXTRA_ARGS...]"

    # Inspect arguments

    if [[ $1 == '-h' || $1 == '--help' ]]; then
        echo "$USAGE"
        return 0
    fi

    if (( $# < 3 )); then
        &>2 echo "$USAGE"
        return 1
    fi

    case "$1" in
        uv)
            shift
            _new_uvenv "$@"
        ;;
        virtualenv)
            shift
            _new_virtualenv "$@"
        ;;
        *)
            &>2 echo "Unknown virtual environment manager $1, only supporting 'uv' and pyenv's 'virtualenv' plugin."
            return 1
        ;;
    esac
}


_new_uvenv() {
    local version=$1
    local envname=$2
    shift 2

    uv venv --python "$version" --prompt "$envname" "$@" || return 1
    echo 'layout uv' > .envrc
    direnv allow
}

_new_virtualenv() {
    local version=$1
    local envname=$2
    shift 2

    pyenv virtualenv "$version" "$envname" "$@" || return 1
    echo "$2" > .python-version
    pyenv rehash
}


# Execute function if run directly
if ! (return &>/dev/null); then
    pyvenv "$@"
fi

