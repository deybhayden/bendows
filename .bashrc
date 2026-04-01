# basic aliases and env vars for Git Bash

# exports
export EDITOR="code -w"
export HISTCONTROL=ignoreboth:erasedups

# misc
alias src="source $HOME/.bash_profile"
alias tf="terraform"

# ai
function agent-browser() {
  if [[ "$1" == "update" ]]; then
    npm install -g agent-browser@latest --loglevel=error
    echo -e "\033[0;32mAgent Browser updated.\033[0m"
  else
    command agent-browser "$@"
  fi
}

# pi
function pi() {
  if [[ "$1" == "update" ]]; then
    npm install -g @mariozechner/pi-coding-agent --loglevel=error
    echo -e "\033[0;32mPi updated.\033[0m"
    command pi update
  else
    command pi "$@"
  fi
}

# directories
alias ..="cd .."
alias .r="cd ~/Repos"
function .v() {
  folder=$(cygpath.exe "$VSCODE_WORKSPACE_FOLDER")
  cd "$folder"
}

# git
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gba="git branch --all"
alias gbd="git branch -D"
alias gbu="git branch --set-upstream-to="
alias gc="git commit"
alias gca="git commit -a"
alias gcan!="git commit -a --amend --no-edit"
alias gcl="git clone"
alias gclean="git clean -id"
alias gco="git checkout"
alias gcp="git cherry-pick"
alias gd="git diff"
alias gdc="git diff --cached"
alias gg="git grep"
alias gl="git pull"
alias glg="git log --stat"
alias glp="git log --stat -p"
alias gp="git push"
alias ggp='git push origin "$(git_current_branch)" --force-with-lease'
alias gr="git remote"
alias grba="git rebase --abort"
alias grbi="git rebase -i"
alias grbc="git rebase --continue"
alias grh="git reset HEAD^ --soft"
alias grs="git restore --staged ."
alias gst="git status"

function git_current_branch() {
  local ref
  ref=$(git symbolic-ref --quiet HEAD 2>/dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return # no git repo.
    ref=$(git rev-parse --short HEAD 2>/dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

function gsmash() {
  git commit -a --no-edit --amend
  git push origin "$(git_current_branch)" --force-with-lease
}

# github cli
alias gha="gh auth status"
alias ghl="gh auth login"
alias ghs="gh auth switch"

# hooks
export _unmangle_direnv_names='PATH'
_unmangle_direnv_paths() {
    for k in $_unmangle_direnv_names; do
        eval "$k=\"\$(/usr/bin/cygpath -p \"\$$k\")\""
    done
}
eval "$(direnv hook bash | sed -e 's@export bash)@export bash)\_unmangle_direnv_paths@')"
