#!/bin/sh

# =============================================================================
# Environment Variables
# =============================================================================
# This script sets up environment variables for the shell and system.
# It includes paths, configuration locations, and other system-wide settings.
# =============================================================================

# =============================================================================
# XDG Base Directory Specification
# =============================================================================
# These variables define the base directories for various types of files
# according to the XDG Base Directory Specification.
# =============================================================================
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# =============================================================================
# Shell Configuration
# =============================================================================
# These variables control various aspects of the shell's behavior.
# =============================================================================
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"
export ZSH_COMPDUMP="${ZSH_CACHE_DIR}/zcompdump-${ZSH_VERSION}"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=true
export ZSH_AUTOSUGGEST_MANUAL_REBIND=true
export SHELL_SESSIONS_DISABLE=1

# =============================================================================
# Editor Configuration
# =============================================================================
# These variables configure the default editor and related settings.
# =============================================================================
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export MANPAGER="less"

# =============================================================================
# Language and Locale
# =============================================================================
# These variables control language and locale settings.
# =============================================================================
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# =============================================================================
# Path Configuration
# =============================================================================
# These variables add directories to the system PATH.
# =============================================================================
# Base paths
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# Development tools paths
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/libpq/bin:$PATH"  # Postgres Client API library
export PATH="$HOMEBREW_PREFIX/share/flutter/bin:$PATH"
export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"

# Development environment paths
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/shims:$PATH"

# =============================================================================
# Application Configuration
# =============================================================================
# These variables configure various applications and tools.
# =============================================================================
# FZF configuration
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d . $HOME"
export FZF_TMUX=1
export FZF_TMUX_OPTS="-p 80%"

# EZA configuration
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"

# Bat configuration
export BAT_THEME=tokyonight_night

# =============================================================================
# System Configuration
# =============================================================================
# These variables configure system-wide settings and behaviors.
# =============================================================================
# Homebrew configuration
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Dotfiles configuration
export DOTFILES=$HOME/.dotfiles

# Kubernetes completion
source <(kubectl completion zsh)

# Buildpack completion
source "$(pack completion -s zsh)"

# Anyenv initialization
eval "$(anyenv init - zsh)"

# Tmuxifier configuration
export TMUXIFIER=$HOMEBREW_PREFIX/opt/tpm/share/tpm/plugins/tmuxifier
export PATH="${TMUXIFIER}/bin:$PATH"
export TMUXIFIER_LAYOUT_PATH="$HOME/.config/tmuxifier/layouts"
eval "$(tmuxifier init -)"

# 1Password CLI completion
eval "$(op completion zsh)"; compdef _op op

# FZF key bindings and fuzzy completion
eval "$(fzf --zsh)"

# TheFuck configuration
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# Zoxide configuration
eval "$(zoxide init --cmd cd zsh)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/mbagrat/.lmstudio/bin"
