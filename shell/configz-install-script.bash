#! /usr/bin/env bash

# Shell utilities installation script.

LOCAL_BIN_PATH="$HOME/.local/bin"


. "$CONFIGZ_TOOLS_DIR/init.bash"


install_dir() {
    local dir="$1"

    local dir_name="${dir##*/}"

    case "$dir_name" in
        functions)
            local func func_name
            for func in "$dir"/*; do
                func_name="${func##*/}"
                configz_lns "$func" "$LOCAL_BIN_PATH/${func_name%.*}"
            done
        ;;
        *) configz_lns "$dir" "$target_dir/$dir_name";;
    esac
}


install() {
    local cwd="${1:?}"

    mkdir -p "$LOCAL_BIN_PATH"

    # Bash files
    configz_lns "$cwd/profile.sh" "$HOME/.profile"
    configz_lns "$cwd/bashrc" "$HOME/.bashrc"

    # Zsh files
    configz_lns "$cwd/profile.sh" "$HOME/.zprofile"
    configz_lns "$cwd/zshrc" "$HOME/.zshrc"

    # -- Generic files/directories --

    local target_dir="${CONFIGZ_DIR:?}/shell"
    mkdir -p "$target_dir"

    configz_lns "$cwd/shellrc" "$target_dir/shellrc"

    local sdir
    for sdir in "$cwd"/*; do
        [[ -d $sdir ]] || continue
        install_dir "$sdir"
    done
}


install "$@"
