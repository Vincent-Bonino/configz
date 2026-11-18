#! /usr/bin/env bash

# Fuzzy find in descending filenames.
# Requires `batcat`, `fzf` and `rg`.

frg() {
    local FRG_OPEN=${FRG_OPEN:-'subl {1}:{2}'}
    local FRG_RELOAD=${FRG_RELOAD:-'reload:rg --color=always --column --smart-case {q} || :'}

    fzf --ansi --disabled --delimiter : \
        --header 'Single file selection - CTRL-o to open file in SublimeText; CTLR-/ to toggle preview' \
        --bind "start:$FRG_RELOAD" --bind "change:$FRG_RELOAD" \
        --bind "enter:become:$FRG_OPEN" --bind "ctrl-o:execute:$FRG_OPEN" \
        --bind "ctrl-/:toggle-preview" \
        --preview 'batcat --color=always --style=full --highlight-line {2} {1}' --preview-window '~4,+{2}+4/3,<80(up)' \
        --query "${@:-TODO}"
}


# Execute function if run directly
if ! (return &>/dev/null); then
    frg "$@"
fi
