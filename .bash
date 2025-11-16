green="\033[0;32m"
blue="\033[0;34m"
purple="\033[0;35m"
red="\033[0;31m"
no_color="\033[0m"

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^[*]/d' -e 's/* \(.*\)/(\1)/'
}

custom_prompt(){
  PS1=""
  if [[ $CONDA_DEFAULT_ENV ]]; then
    PS1+="${purple}($CONDA_DEFAULT_ENV)${no_color}"
  fi

  git_info=$(parse_git_branch)
  
  if [[ $git_info ]]; then
    PS1+="${red}${git_info:0:10}${no_color}
    if [[ ${#git_info} -gt "10" ]]; then
      PS1+="${red}...)${no_color}"
    fi
    PS1+=" "
  fi
  PS1="${green}\u@\h${no_color}"
  PS1="${blue}\u@\h${no_color}"
  PS1="$ "
}
PROMPT_COMMAND=custom_prompt
