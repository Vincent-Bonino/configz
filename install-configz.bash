#! /usr/bin/env bash

# Install configz.
#
# Configz can install programs' "dependencies" but not some "requirements".
# NOTE: Note that some general requirements are not explicitly checked but
# might cause errors while installing dependencies (e.g. a c compiler).
#
# Depencendy:   program that will be installed (e.g. rust crate, ...)
# Requirements: program than won't be installed (e.g. cargo itself)

# TODO: handle WSL

CONFIGZ_VERSION="0.1.0"

# Possible values
#  - link       Create a symbolic link to the directory
#               Useful with git for tracking files
#  - script     Call the 'configz-install-script.bash' script.
declare -A CONFIGZ_INSTALL_METHOD=(
    ['git']='link'
    ['oh-my-posh']='link'
    ['nvim']='link'
    ['shell']='script'
    ['tmux']='link'
)



# --- Internal config ---

export CONFIGZ_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
export CONFIGZ_TOOLS_DIR='configz-tools'

CONFIGZ_SUBSCRIPT='configz-install-script.bash'

# Values are ':' separated lists.
declare -A PROGRAM_REQUIREMENTS=(
    ['git']='cargo'
    ['nvim']='cargo'
    ['shell']='cargo'
)

. "$CONFIGZ_TOOLS_DIR/init.bash" || { >&2 echo "Unable to source tools"; return 1; } 

# Value given via CLI arguments
export CONFIGZ_FLAG_FORCE=false
export CONFIGZ_FLAG_UPGRADE=false
CONFIGZ_PROGRAMS=()

usage() {
    echo "$0 [CONFIG_TO_INSTALL...]"
    echo
    echo "Install configuration files (sometimes called dotfiles)."
    echo "By default (if none is provided as an argument), install all configurations."
    echo "Otherwise install only provided ones."
    echo
    echo "Version: $CONFIGZ_VERSION"
    echo
    echo "Options:"
    echo "  -h, --help      Show this message and exit"
    echo "  -U, --upgrade   Allow an update with breaking changes"
    echo "  -f, --force     Allow removing existing configurations"
}


error() {
    >&2 echo "$@"
    exit 1
}


# -- Requirements --

assert_requirements() {
    local requirements=() tmp

    for prog in "$@"; do
        IFS=':' read -r -a tmp <<< "${PROGRAM_REQUIREMENTS[$prog]}"
        requirements+=("${tmp[@]}")
    done

    requirements=( $(echo "${requirements[@]}" | sort -u) )

    local cmd errs=()
    for cmd in "${requirements[@]}"; do
        command -v "$cmd" &> /dev/null || errs+=("$cmd")
    done

    if (( ${#errs[@]} > 0 )); then
        IFS=',' error 'Missing required command(s)' "${errs[*]}"
    fi
}


# -- Installation --

# TODO: clean
install() {
    local program="$1"
    echo "[i] [$program] Installing..."

    # Verify destination does not already exists
    local dst="$CONFIGZ_DIR/$program"
    if [[ -e $dst ]]; then
        if [[ ! -L $dst ]]; then
            if ! "$CONFIGZ_FLAG_FORCE"; then
                error "Refusing to overwrite config of '$program' without --force flag"
            else
                configz_backup "$dst"
            fi
        else
            :  # Assuming it is being managed by configz
        fi
    fi

    # Dependencies
    install_dependencies "$program"

    # Install
    [[ -L "$dst" ]] && { echo "[i] '$program' is already installed"; return 0; }
    local method="${CONFIGZ_INSTALL_METHOD[$program]}"

    case "$method" in
        # copy) cp -r "$program" "$CONFIGZ_DIR/$program";;
        link) ln -s "$PWD/$program" "$CONFIGZ_DIR/$program";;
        script) "$PWD/$program/$CONFIGZ_SUBSCRIPT" "$PWD/$program";;
        *)
            error "Invalid install method '$method'"
    esac
}


install_dependencies() {
    local program="$1" dependencies

    set -e  # Ensure no dependency installation error
    case "$program" in
        git)
            dependencies=(difft)
            configz_install_dep 'cargo' "${dependencies[@]}"
        ;;
        nvim)
            dependencies=(tree-sitter-cli)
            configz_install_dep 'cargo' "${dependencies[@]}"
        ;;
        shell)
            dependencies=(eza fd-find ripgrep)
            configz_install_dep 'cargo' "${dependencies[@]}"
        ;;
    esac
}


# -- Execution --

VERSION_RE='([0-9]+)\.([0-9]+)\.([0-9]+)'

# Compare the current installed and the new (this script's) version of configz.
#
# Return code:
#  - 0: Installation can happen
#  - 1: Nothing to install
verify_version() {
    if [[ -z $INSTALLED_CONFIGZ_VERSION ]]; then
        echo '[i] Performing initial installation' 
        return 0
    fi

    local installed_version
    [[ $INSTALLED_CONFIGZ_VERSION =~ $VERSION_RE ]]
    installed_version=("${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}" "${BASH_REMATCH[3]}")

    local new_version
    [[ $CONFIGZ_VERSION =~ $VERSION_RE ]]
    new_version=("${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}" "${BASH_REMATCH[3]}")

    # Compare versions

    # Major (breaking change)
    if (( new_version[0] > installed_version[0] )); then
        if ! $CONFIGZ_FLAG_UPGRADE; then
            error 'Update might contain breaking changes, run with '--upgrade' flag to confirm'
        else
            echo '[i] Performing major update...'
            return 0
        fi

    # Minor (feature)
    elif (( new_version[1] > installed_version[1] )); then
        echo '[i] Performing minor update...'
        return 0

    # Patch (fix)
    elif (( new_version[2] > installed_version[2] )); then
        echo '[i] Performing patch update...'
        return 0
    fi

    echo "[i] Already up-to-date"
    return 1
}


main() {
    local retcode=0

    # Parse arguments

    local arg has_error=false
    for arg in "$@"; do
        case "$arg" in
            -h|--help) usage; return 0;;
            -U|--upgrade) CONFIGZ_FLAG_UPGRADE=true;;

            -f|--force) CONFIGZ_FLAG_FORCE=true;;

            -*)
                >&2 echo "Unknown option '$arg'"
                has_error=true
            ;;
            *)
                if [[ -d "$arg" && -n "${CONFIGZ_INSTALL_METHOD[$arg]}" ]]; then
                    CONFIGZ_PROGRAMS+=("$arg")
                else
                    >&2 echo "Unknown program '$arg'"
                    has_error=true
                fi
            ;;
        esac
        shift
    done

    "$has_error" && { >&2 usage; return 2; }

    # By default, install every program
    (( ${#CONFIGZ_PROGRAMS[@]} == 0 )) && CONFIGZ_PROGRAMS=("${!CONFIGZ_INSTALL_METHOD[@]}")


    # Verify version
    verify_version || return 0


    # Requirements
    assert_requirements "${CONFIGZ_PROGRAMS[@]}" || return 1


    # Install programs
    local program
    for program in "${CONFIGZ_PROGRAMS[@]}"; do
        [[ -d $program ]] || continue
        [[ $program = *configz* ]] && continue

        install "$program" || retcode=1
    done

    return "$retcode"
}


main "$@"
