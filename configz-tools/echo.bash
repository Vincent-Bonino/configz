# Different utility functions around `echo`.

## Colored echos

echo_blue() {
    echo -e "${BLUE}$*${RESET}"
}

echo_green() {
    echo -e "${GREEN}$*${RESET}"
}

echo_orange() {
    echo -e "${ORANGE}$*${RESET}"
}

echo_red() {
    echo -e "${RED}$*${RESET}"
}


## Log functions

log_info() {
    echo -e "$BLUE"         " [INFO]    $RESET" "$@"
}

log_warning() {
    >&2 echo -e "$ORANGE"   " [WARNING] $RESET" "$@"
}

log_error() {
    >&2 echo -e "$RED"      " [ERROR]   $RESET" "$@"
}
