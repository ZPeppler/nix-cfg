export STARSHIP_CONFIG="/etc/starship-root.toml"
export PATH="$HOME/.config/bin:$HOME/.local/share/bin:$HOME/.local/bin:$HOME/.config/zide/bin/:$PATH"
eval "$(starship init zsh)"
# eval "$(ssh-agent -s)"
#. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"
eval "$(tv init zsh)"
[[ -f $HOME/.venv/bin/activate ]] && source $HOME/.venv/bin/activate

(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

source $HOME/.config/fzf/theme.sh

# Tmux autostart logic
if command -v tmux >/dev/null 2>&1; then
  # VS Code: attach to a dedicated session
  if [[ -z "$TMUX" && -n "$VSCODE_IPC_HOOK_CLI" || "$TERM_PROGRAM" = "vscode" ]]; then
    tmux attach-session -t code || tmux new-session -s code
  # SSH: attach to a dedicated SSH session
  elif [[ -z "$TMUX" && -n "$SSH_TTY" ]]; then
    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
  # Neovide: attach to a dedicated Neovide session
  elif [[ -z "$TMUX" && -n "$NEOVIDE" ]]; then
    tmux attach-session -t neovide || tmux new-session -s neovide
  # Regular terminal: attach to main session (not in VS Code, Emacs, Vim, IntelliJ)
  elif [[ -z "$TMUX" && \
          -z "$VSCODE_IPC_HOOK_CLI" && \
          -z "$VSCODE_INJECTION" && \
          -z "$INSIDE_EMACS" && \
          -z "$EMACS" && \
          -z "$VIM" && \
          -z "$INTELLIJ_ENVIRONMENT_READER" ]]; then
  (tmux has-session -t home 2>/dev/null && tmux attach -t home) || tmux new-session -s home 
  fi
fi

eval "$(zoxide init zsh)"
# export EZA_DEFAULT_THEME="$HOME/.config/eza/theme/onedarkpro.yml"

### FZF ###
# Enables the following keybindings:
# CTRL-t = fzf select
# CTRL-r = fzf history
# ALT-c  = fzf cd
eval "$(fzf --zsh)"
fpath=(~/.config/zsh/completions $fpath)
autoload -U compinit && compinit
