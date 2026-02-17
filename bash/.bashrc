# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
# Aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'
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

# Dev container specific configuration
if [ -f /run/.containerenv ] && grep -q "name=\"dev\"" /run/.containerenv 2>/dev/null; then
  eval "$(starship init bash)"
  eval "$(direnv hook bash)"
  eval "$(fzf --bash)"
  source ~/.nix-profile/etc/profile.d/nix.sh

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

  alias dotfiles='cd ~/dotfiles/'
  alias lab='cd ~/repos/homelab/'
  alias genshell='nix develop ~/devshells/general/'
  alias v='nvim'
  alias ??='fabric'
  alias sb='cd ~/repos/second-brain/'

  function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd <"$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
  }

  export EDITOR=nvim
  export VISUAL=nvim

  if [ -e /home/willy/.nix-profile/etc/profile.d/nix.sh ]; then
    . /home/willy/.nix-profile/etc/profile.d/nix.sh
  fi
fi

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc
