eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias home='cd ~'
alias dotfiles='cd ~/dotfiles/'
alias lab='cd ~/repos/homelab/'
alias genshell='nix develop ~/devshells/general/'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cls='clear'
alias v='nvim'

export EDITOR=nvim
export VISUAL=nvim

# Auto-start hyprland
if [[ -z "$WAYLAND_DISPLAY" ]] && [[ "$XDG_VTNR" -eq 1 ]]; then
	start-hyprland
fi
