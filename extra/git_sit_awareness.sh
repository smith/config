# -*- mode: sh -*-

INSTALLER_VERSION=2
PROMPT_COLOR_ONE='\['`tput setaf 2`'\]'
PROMPT_COLOR_TWO='\['`tput setaf 5`'\]'
PROMPT_PLAIN='\['`tput op`'\]'
SHORT_HASH_LENGTH=10
TIMEOUT_USECONDS=500000

utimeout () {
    perl -e 'use Time::HiRes qw(ualarm); ualarm shift; exec @ARGV' "$@";
}

git_dir() {
    [ -d ".git" ] && echo ".git" || git rev-parse --git-dir 2>/dev/null
}

in_git_repo() {
    git_dir &>/dev/null
}

git_status_indicator() {
    if in_git_repo; then
        git_status="$(utimeout $TIMEOUT_USECONDS git status --porcelain 2>/dev/null)"
        if [ "$?" != "0" ]; then
            printf "!"
            return
        fi
        if [ -z "$git_status" ]; then
            return
        fi
        if echo "$git_status" | grep '^ .' &>/dev/null; then
            printf "+" # unstaged
        fi
        if echo "$git_status" | grep '^. ' &>/dev/null; then
            printf "*" # staged
        fi
        if echo "$git_status" | egrep '^(U.|.U)' &>/dev/null; then
            printf "#" # unmerged
        fi
        if echo "$git_status" | grep '??' &>/dev/null; then
            printf "·" # untracked
        fi
    fi
}

git_branch() {
    git_directory="$(git_dir)"
    if [ "$git_directory" ]; then
        grep "ref:" "$git_directory/HEAD" &>/dev/null && 
        rev "$git_directory/HEAD" | cut -d"/" -f-1 | rev ||   # branch names
        git describe --exact-match --tags HEAD 2>/dev/null || # tags
        cut -c-$SHORT_HASH_LENGTH < "$git_directory/HEAD"     # commit sha1 hashes
    fi
}

git_branch_separator() {
    if in_git_repo; then
        echo ":"
    fi
}

git_stash_height() {
    if in_git_repo; then
        stash_height="$(git stash list | wc -l | awk '{ print $1 }')"
        if [ $stash_height = "0" ]; then
            stash_height=""
        fi 
        echo "$stash_height"
    fi
}

git_stash_height_separator() {
    if [ "$(git_stash_height)" ]; then
        echo ":"
    fi
}

export HAVE_GIT_SIT_AWARENESS=$INSTALLER_VERSION

# tweak this as you see fit
export PS1="\[\e[0;32m\]\u@\h\[\e[0m\]:\[\e[1;36m\]\w\[\e[0m\]\$(git_branch_separator 2>/dev/null)${PROMPT_COLOR_TWO}\$(git_status_indicator 2>/dev/null)${PROMPT_COLOR_ONE}\$(git_branch 2>/dev/null)${PROMPT_PLAIN}\$(git_stash_height_separator 2>/dev/null)${PROMPT_COLOR_TWO}\$(git_stash_height 2>/dev/null)${PROMPT_PLAIN}\$ "
