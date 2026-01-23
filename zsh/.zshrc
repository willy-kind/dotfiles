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
--color=bg:#2f383e,bg+:#374247,fg:#d3c6aa,fg+:#d3c6aa
--color=border:#4a555b,spinner:#83c092,hl:#7fbbb3
--color=header:#7fbbb3,info:#a7c080,pointer:#a7c080
--color=marker:#dbbc7f,fg+:#d3c6aa,hl+:#e67e80
--color=prompt:#a7c080
--border=rounded
--layout=reverse
--height=90%
"

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --preview 'bat --style=numbers --color=always {}'"
export BAT_THEME="Everforest Dark"

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
