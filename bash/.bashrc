#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=nvim
export VISUAL=nvim
export HYPRSHOT_DIR=~/Pictures/
export XDG_PICTURES_DIR=~/Pictures/
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cls='clear'
export 
PS1='[\u@\h \W]\$ '
eval "$(starship init bash)"

# This variable is set to the folder .NET was installed to, such as 
# $HOME/.dotnet: 
export DOTNET_ROOT=$HOME/.dotnet
export DOTNET_ENVIRONMENT=Development

# This variable should include both the DOTNET_ROOT folder and the 
# DOTNET_ROOT/tools folder:
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

eval "$(fzf --bash)"
