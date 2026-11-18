# TODO:


# Interactively select the branch to checkout to.
#
# Dependency: `fzf`
git_checkout_interactive() {
    git branch --sort=refname | \
        fzf --cycle --preview 'git show --stat --color="always" {-1}' \
        --preview-window 'right' --bind 'enter:become(git checkout {-1})'
}
alias gcki='git_checkout_interactive'

# Remove local branches whose remote have been merged.
#
# Also remove local tags that have be deleted on remote.
git_clean_branches() {
    local PROTECTED_BRANCHES="main|master|develop"

    git branch -d $(git branch --merged | grep -E -v "$PROTECTED_BRANCHES")
    git fetch -q --prune --prune-tags
}

# Push the branch and create a merge request at the same time.
#
# Make for GitLab.
# Only works if pushing the branch at the same time (first push)
git_push_merge_request() {
    local target="$1"
    local title="$2"

    if [[ "$target" = "-m" ]]; then
        target="master"
    elif [[ "$target" = "-d" ]]; then
        target="develop"
    fi

    if [[ -z "$target" ]]; then
        read -r "?Target branch: " target
    fi
    if [[ -z "$title" ]]; then
        read -r "?Title: " title
    fi

    git push \
        -o merge_request.create \
        -o merge_request.target="$target" \
        -o merge_request.remove_source_branch \
        -o merge_request.title="$title" \
        -o merge_request.unassign="XXXX"  # By default the MR is assigned to self
}
alias gpmr='git_push_merge_request'

# Fetch and pull important branches.
#
# Parameters:
#   1. Quiet mode: -q|--quiet
git_sync() {
    local curr_branch quiet

    if [[ $1 == '-q' || $1 == '--help' ]]; then
        quiet="--quiet"
    fi

    # Save current branch to get back on it after
    curr_branch="$(git rev-parse --abbref-ref HEAD 2> /dev/null)"

    # 1. Fetch
    git fetch origin $quiet

    # 2. Update branches
    process_branch() {
        local branch_name=$1
        [[ $quiet ]] || echo_blue "---------- $branch_name ----------"
        git checkout "$branch_name" $quiet && git pull origin $quiet
    }

    process_branch 'main'
    process_branch 'master'
    process_branch 'develop'

    git checkout "$curr_branch" $quiet
}


## Local hooks

# Install git hooks for the current git repository.
git_hook() {
    local HOOK_PATH HOOKS hook source target
    HOOK_PATH="TODO"
    HOOKS=('pre-commit' 'commit-msg' 'pre-push')

    for hook in "${HOOKS[@]}"; do
        source="$HOOK_PATH/$hook"
        target=".git/hooks/$hook"

        info "Adding '$hook' hook"
        cp "$source" "$target"
        chmod 755 "$target"
    done
}

git_unhook() {
    HOOKS=('pre-commit' 'commit-msg' 'pre-push')

    for hook in "${HOOKS[@]}"; do
        rm -f ".git/hooks/$hook"
    done
}
