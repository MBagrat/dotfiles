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