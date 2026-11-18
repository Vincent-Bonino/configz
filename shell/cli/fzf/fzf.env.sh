# Default command for finding
export FZF_DEFAULT_COMMAND='fd --type file --color=always --follow'

# Default options when run
export FZF_DEFAULT_OPTS='--height 95% --layout=reverse --border --ansi'

# Options for fzf completion
# export FZF_COMPLETION_TRIGGER='**'  # Default
export FZF_COMPLETION_OPTS='--border --info=inline'

# Options when using ALT-C (cd to chosen directory)
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# Options when using CTRL-T (copy filepath to command line)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,target,__pycache__
  --preview 'batcat -n --color=always {}'
  --bind 'ctrl-/:toggle-preview'
  --header 'Press CRTL-/ to toggle preview.'"
