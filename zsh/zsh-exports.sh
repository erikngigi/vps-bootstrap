#!/usr/bin/env bash

# Paths
# Local bin
export PATH="$HOME/.local/bin:$PATH"

# Rust/Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Pager & Man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
export MANWIDTH="${COLUMNS:-120}"

# FZF & NNN (CLI Tools)
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export NNN_PLUG='r:renamer'
export NNN_TRASH=1
export NNN_COLORS='#27272727'
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
export NNN_BMS="d:/storage/Downloads;e:/storage/Tv-Shows;h:$HOME/;m:/storage/Movies;t:/storage/Torrents;s:/storage/;y:$HOME/Yggdrasil"

# Editor & Browser
export EDITOR="/opt/nvim/bin/nvim"

# XDG
# User directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# System directories
export XDG_DATA_DIRS="/usr/local/share:/usr/share"

# System
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

# Disable Python Prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1
