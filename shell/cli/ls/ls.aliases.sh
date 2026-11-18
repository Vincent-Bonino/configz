if ! command -v eza &> /dev/null; then
    alias l='ls -CF'
    alias la='ls -A'
    alias ll='ls -lh'
    alias lla='ls -lhA'
    alias llt='ls -lhtc'
    alias ls='ls --color=auto'
fi
