#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ -n $DISPLAY ]] || [[ $(tty) != /dev/tty1 ]]; then
  eval "$(starship init bash)"
fi

alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias home='cd ~'
alias lab='cd ~/repo/homelab/'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cls='clear'
alias v='nvim'

export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export GPG_TTY=$(tty)
