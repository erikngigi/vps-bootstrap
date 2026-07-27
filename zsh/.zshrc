# Path Deduplication
# Must be set before any sources that modify PATH
typeset -U PATH path

# History
# HISTFILESIZE is a bash variabke and is ignored in zsh; use SAVEHIST instead
# These are zsh options, not env vars - no export needed
HISTFILESIZE=1000000
SAVEHIST=10000001
HISTFILE=~/.zsh_history
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_SPACE
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# Load compinit
autoload -Uz compinit
if [[ -n $ZDOTDIR/.zcompdump(#qN.mh+24) ]]; then
  compinit -u # dump is stale — regenerate
else
  compinit -i -C # dump is fresh — skip audit, saves ~400ms
fi

autoload -Uz bashcompinit
bashcompinit

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Plugins
# External community plugins load first
# NOTE: zsh-syntax-highlighting must remain last
plug "zap-zsh/supercharge"
plug "hlissner/zsh-autopair"
plug "zsh-users/zsh-history-substring-search"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"

# Custom configurations come after community plugins
plug "$HOME/.config/zsh/zsh-exports.sh"
plug "$HOME/.config/zsh/zsh-functions.sh"
plug "$HOME/.config/zsh/zsh-prompt.sh"
plug "$HOME/.config/zsh/zsh-vim.sh"
plug "$HOME/.config/zsh/zsh-aliases.sh"

# Completion styles after compinit
zstyle ':completion:*' special-dirs false
zstyle ':completion::complete:*' use-cache 1

# Better SSH/Rsync/SCP Autocomplete
zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host'
zstyle ':completion:*:hosts-host' list-colors '=(#b)(*)( *)=00;34=00;31'
zstyle ':completion:*:nodes' ignored-patterns '*(.|:)*' loopback localhost
my_ssh_hosts=($([ -f ~/.ssh/config ] && grep -i "^Host" ~/.ssh/config | grep -v "[*?]" | awk '{print $2}'))
zstyle ':completion:*:hosts' hosts $my_ssh_hosts
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost

# Autocomplete for usctl
_usctl() {
  local -a cmds
  cmds=(enable disable restart start stop status)

  if ((CURRENT == 2)); then
    # First arg: complete subcommands
    _describe 'command' cmds
  elif ((CURRENT == 3)); then
    # Second arg: complete service names
    local -a services
    services=($(systemctl --user list-unit-files --type=service --quiet | awk '{print $1}'))
    _describe 'service' services
  fi
}

# Autocomplete for ssctl
_ssctl() {
  local -a cmds
  cmds=(enable disable restart start stop status)

  if ((CURRENT == 2)); then
    # First arg: complete subcommands
    _describe 'command' cmds
  elif ((CURRENT == 3)); then
    # Second arg: complete service names
    local -a services
    services=($(systemctl list-unit-files --type=service --quiet | awk '{print $1}'))
    _describe 'service' services
  fi
}

compdef _usctl usctl
compdef _ssctl ssctl

# Add zoxide
eval "$(zoxide init --cmd cd zsh)"

# Confirm ssh-agent is running
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
fi
