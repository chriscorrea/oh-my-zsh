# Clean prompt with simple git indicators. Reccomend a dark background.
# Colors: black, cyan, Boldred, blue, boldBlue, boldBlack, yellow
# Last Modified: September 2014

# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname
}

# Custom Prompt
function _prompt_char() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    echo "%{%F{blue}%}±%{%f%k%b%}"
  else
    echo ' '
  fi
}

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$terminfo[bold]$fg[black]%}[git:%{$terminfo[bold]$terminfo[bold]$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$terminfo[bold]$fg[black]%}]%}%{$reset_color%}%{$fg[red]%}●"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$terminfo[bold]$fg[black]%}]%}%{$terminfo[bold]$fg[yellow]%}●"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$terminfo[bold]$fg[black]%}]%}%{$terminfo[bold]$fg[black]%}●"

# Prompt Format: USER@MACHINE DIRECTORY [git:BRANCH] STATE(color) \n %# (# for priviledged) 

PROMPT="
%{$fg_bold[blue]%}%n%{$reset_color%}\
%{$fg[blue]%}@\
%{$fg[blue]%}$(box_name) \
%{$fg[yellow]%}${current_dir}%{$reset_color%}\
${git_info} 
$(_prompt_char)%{$terminfo[bold]$fg[black]%} %# %{$reset_color%}"

if [[ "$(whoami)" == "root" ]]; then
PROMPT="
%{$bg[yellow]%}%{$fg[blue]%}%n%{$reset_color%}\
%{$fg[white]%}@\
%{$fg[blue]%}$(box_name) \
%{$fg[yellow]%}${current_dir}%{$reset_color%}\
${git_info} 
$(_prompt_char)%{$terminfo[bold]$fg[red]%} %# %{$reset_color%}"
fi
