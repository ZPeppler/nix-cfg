# LS aliases to replace them with eza
alias ls='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first'
alias ll='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -l --git -h'
alias la='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a'
alias lla='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a -l --git -h'

# CD alias to replace it with zoxicde and list with EZA
alias cl='zoxide_cd_and_list'
alias cd='z'

# replaced aliases
alias lso='/usr/bin/ls'
alias cdo='/usr/bin/cd'

# FZF
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

# Updated NIXOS config
alias nrs="sudo nixos-rebuild switch --flake $HOME/Projects/nixos-dotfiles#$(hostname)"
alias nrb="sudo nixos-rebuild boot --flake $HOME/Projects/nixos-dotfiles#$(hostname)"
