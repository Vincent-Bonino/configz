#! /usr/bin/env bash

# Configz utilities for installing dependencies.

configz_install_dep() {
    local tool="$1"
    shift

    case "$tool" in
        apt)   _configz_install_apt_dep "$@";;
        cargo) _configz_install_cargo_dep "$@";;
        *)
            >&2 echo "Unknown dependency installation tool '$tool'"
            return 1
        ;;
    esac
}


_configz_install_apt_dep() {
    echo ""
    sudo apt update
    sudo apt install "$@"
}

_configz_install_cargo_dep() {
    cargo install "$@"
}
