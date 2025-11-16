green="\[\033[01;32m\]"
blue="\[\033[01;34m\]"
purple="\[\033[01;35m\]"
red="\[\033[01;31m\]"
no_color="\[\033[00m\]"

parse_git_branch() {
  git branch 2>/dev/null | sed -n 's/^\* \(.*\)/(\1)/p'
}

custom_prompt() {
  PS1=""

  if [[ $CONDA_DEFAULT_ENV ]]; then
    PS1+="${purple}($CONDA_DEFAULT_ENV)${no_color}"
  fi

  git_info=$(parse_git_branch)

        if [[ $git_info ]]; then
          branch="${git_info:1:-1}"  # remove ( )
          trunc="${branch:0:10}"

          if [[ ${#branch} -gt 10 ]]; then
            PS1+=" ${red}(${trunc}...)${no_color}"
          else
            PS1+=" ${red}(${branch})${no_color}"
          fi
        fi

  PS1+=" ${green}\u@\h${no_color}"
  PS1+="$ "
}
