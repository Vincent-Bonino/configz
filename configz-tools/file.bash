#! /usr/bin/env bash

# File management utilities.

# Create a backup of a file/dir.
configz_backup() {
    local path="$1"

    [[ "${CONFIGZ_NO_BACKUP:-0}" != 0 ]] || return 0

    # Do not backup symbolic links, makes no sense
    [[ ! -L "$path" ]] || return 0

    echo "[!] Backup (just in case)"
    mv -v "$1" "$1.configz-backup"
}

# Create a symbolic link, with care for overwrites.
#
# Parameters
#  - Source file/dir
#  - Target file/dir
configz_lns() {
    local USAGE="usage: $0 SRC DST"
    local src="$1" dst="$2"

    # Verify parameters
    (( $# == 2 )) || { >&2 echo "$USAGE"; return 1; }
    [[ -e $src ]] || { >&2 echo "$0: Src ($src) does not exist"; return 1; }

    # Process
    if [[ -e $dst ]]; then
        if [[ $CONFIGZ_FLAG_FORCE == true ]]; then
            configz_backup "$dst"
        else
            >&2 echo "$0: Refusing to overwrite '$dst'"
            return 1
        fi
    fi

    # TODO: issue when already existing
    ln --force --symbolic "$src" "$dst"
}
