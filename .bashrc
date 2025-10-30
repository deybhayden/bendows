# basic aliases and env vars for Git Bash

export EDITOR="code -w"

# misc
alias src="source $HOME/.bash_profile"
alias tf="terraform"

# directories
alias ..="cd .."
alias .r="cd ~/Repos"
function .v() {
  folder=$(cygpath.exe "$VSCODE_WORKSPACE_FOLDER")
  cd "$folder"
}

# git
alias .g='cd "$(git rev-parse --show-toplevel 2>/dev/null || echo .)"'
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

# hooks
eval "$(direnv hook bash)"
