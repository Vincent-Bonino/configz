#! /usr/bin/env bash

# Deactivate the current UV virtual environment.
#
# Note that UV_ACTIVE will only be unset if sourced.

uvd() {
    if [[ -z $UV_ACTIVE ]]; then
        return
    fi

    deactivate
    unset $UV_ACTIVE
}


# Execute function if run directly
if ! (return &>/dev/null); then
    uvd "$@"
fi

