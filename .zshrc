export ZSH="/home/matthias/.oh-my-zsh"

ZSH_THEME="steeef"

plugins=(git zsh-autosuggestions z)

source $ZSH/oh-my-zsh.sh

#Env
export EDITOR=emacs

# Aliases
alias tmp='cd $(mktemp -d)'
