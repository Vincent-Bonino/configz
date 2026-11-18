#! /usr/bin/env bash

# Fuzzy find in descending filenames.
# Requires `batcat`, `fzf` and `fd`.

ffd() {
    local FFD_OPEN=${FFD_OPEN:-'subl {1}'}
    local FFD_RELOAD=${FFD_RELOAD:-'reload:fd --type file --color=always {q} || :'}

    fzf --ansi --disabled --delimiter : \
        --header 'Single file selection - CTRL-o to open file in SublimeText; CTLR-/ to toggle preview' \
        --bind "start:$FFD_RELOAD" --bind "change:$FFD_RELOAD" \
        --bind "enter:become:$FFD_OPEN" --bind "ctrl-o:execute:$FFD_OPEN" \
        --bind "ctrl-/:toggle-preview" \
        --preview 'batcat --color=always --style=full {1}' --preview-window '~4,+{2}+4/3,<80(up)' \
        --query "${@:-TODO}"
}



# Execute function if run directly
if ! (return &>/dev/null); then
    ffd "$@"
fi
