#! /usr/bin/env zsh

# Ports of bash features to zsh.

help() {
    >&2 echo "bash -c 'help $*'"
    bash -c "help $*"
}

