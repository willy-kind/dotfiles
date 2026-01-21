eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
source <(fzf --zsh)
source ~/.nix-profile/etc/profile.d/nix.sh

export FZF_DEFAULT_OPTS='
  --height=40%
  --layout=reverse
  --border
  --inline-info
'

export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

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

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

export EDITOR=nvim
export VISUAL=nvim

if [ -e /home/willy/.nix-profile/etc/profile.d/nix.sh ]; then . /home/willy/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
