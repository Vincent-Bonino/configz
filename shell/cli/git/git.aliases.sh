alias g='git'

# Add
alias ga='git add'
alias gau='git add --update'

# Checkout
alias gck='git checkout'

# Commit
alias gc='git commit'
alias gca='git commit --amend'
alias gcan='git commit --no-verify --amend'
alias gcane='git commit --amend --no-edit'
alias gcm='git commit --message'
alias gcmn='git commit --no-verify --message'
alias gcn='git commit --no-verify'
alias gcna='git commit --no-verify --amend'
alias gcnm='git commit --no-verify --message'

# Diff
alias gd='git diff'
alias gdc='git diff --check'
alias gdh='git diff HEAD'

# Log
alias gl='git log'
alias glg='git log --oneline --graph'
alias glo='git log --oneline'

# Pull
alias gfp='git fetch; git pull'

# Push
alias gp='git push'
alias gpnci='git push -o ci.skip'

# Rebase
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase --interactive'
alias grid='git rebase --interactive develop'
alias grim='git rebase --interactive main'

# Status
alias gs='git status'


# Misc
alias gcd='cd $(git rev-parse --show-toplevel)'
