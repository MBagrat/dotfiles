#!/bin/zsh

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
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump/zcompdump-${ZSH_VERSION}"

autoload -Uz compinit
# Rebuild compdump once per day; use cached version otherwise (-C skips security check)
if [[ -n ${ZSH_COMPDUMP}(#qN.mh+24) ]]; then
  compinit -d $ZSH_COMPDUMP
else
  compinit -C -d $ZSH_COMPDUMP
fi

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
if [ ! -d "$HOME/.docker/completions" ]; then
  FPATH="$HOME/.docker/completions:$FPATH"
fi

# Kubernetes completion — cached to avoid spawning kubectl on every shell start
_kubectl_completion="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions/_kubectl"
if command -v kubectl >/dev/null 2>&1; then
  if [[ ! -f $_kubectl_completion || $_kubectl_completion -ot $(command -v kubectl) ]]; then
    mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions"
    kubectl completion zsh >$_kubectl_completion
  fi
  source $_kubectl_completion
fi

# Buildpack completion — pack manages its own file; source it directly
if command -v pack >/dev/null 2>&1; then
  source "$(pack completion -s zsh)"
fi

# 1Password CLI completion — cached to avoid spawning op on every shell start
_op_completion="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions/_op"
if command -v op >/dev/null 2>&1; then
  if [[ ! -f $_op_completion || $_op_completion -ot $(command -v op) ]]; then
    mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions"
    op completion zsh >$_op_completion
  fi
  source $_op_completion
  compdef _op op
fi 
