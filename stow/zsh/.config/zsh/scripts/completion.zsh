#!/bin/sh

# =============================================================================
# Completion System Configuration
# =============================================================================
# This script configures the Zsh completion system, providing intelligent
# command and argument completion. It works in conjunction with the completion
# options set in options.zsh and performance.zsh.
# =============================================================================

# =============================================================================
# Completion Initialization
# =============================================================================
# Initialize the completion system and load completion functions.
# =============================================================================
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"

# =============================================================================
# Completion Styles
# =============================================================================
# Configure how completions are displayed and selected.
# =============================================================================
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Completion options
setopt COMPLETE_IN_WORD       # Allow completion from within a word
setopt ALWAYS_TO_END          # Move cursor to the end of a completed word
setopt AUTO_MENU              # Show completion menu on a successive tab press
setopt AUTO_LIST              # Automatically list choices on ambiguous completion

# =============================================================================
# Performance Optimizations
# =============================================================================
# Cache completion results for better performance.
# =============================================================================
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"
zstyle ':completion:*' accept-exact '*(N)'

# =============================================================================
# External Tool Completions
# =============================================================================
# Load completion functions for external tools and applications.
# =============================================================================

# Docker completion
if [ -d "$HOME/.docker/completions" ]; then
  FPATH="$HOME/.docker/completions:$FPATH"
fi

# Kubernetes completion
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

# Buildpack completion
if command -v pack >/dev/null 2>&1; then
  source "$(pack completion -s zsh)"
fi

# 1Password CLI completion
if command -v op >/dev/null 2>&1; then
  eval "$(op completion zsh)"; compdef _op op
fi 