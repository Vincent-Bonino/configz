# -- Env. var. --

# System
export EDITOR='nvim'

export PATH
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:/opt/nvim/nvim-linux-x86_64-0.12.5/bin"  # TODO: temp

export MANPATH="/usr/local/man:$MANPATH"

export CONFIGZ_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

# Colors
export BLACK="\e[0;30m"
export RED="\e[0;31m"
export GREEN="\e[0;32m"
export ORANGE="\e[0;33m"
export BLUE="\e[0;34m"
export PURPLE="\e[0;35m"
export CYAN="\e[0;36m"
export GRAY="\e[0;37m"

export RESET="\e[0m"


# -- Multi-shell --

export CONFIGZ_SHELL=''
if [ -n "$BASH_VERSION" ]; then
    CONFIGZ_SHELL="bash"
    . "$HOME/.bashrc"

elif [ -n "$ZSH_VERSION" ]; then
    CONFIGZ_SHELL="zsh"
    source "$HOME/.zshrc"

else
    >&2 echo "Unknown shell to configz, no additional setup"
fi
