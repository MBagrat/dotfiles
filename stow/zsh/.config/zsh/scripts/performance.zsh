#!/bin/sh

# =============================================================================
# Performance Optimization
# =============================================================================
# This script contains settings and configurations to optimize Zsh performance.
# It includes settings for the completion system, prompt rendering, and other
# performance-critical aspects of the shell.
# =============================================================================

# =============================================================================
# Completion System Optimization
# =============================================================================
# These settings optimize the Zsh completion system for better performance.
# =============================================================================
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

# =============================================================================
# Prompt Performance
# =============================================================================
# These settings optimize prompt rendering and update frequency.
# =============================================================================
zstyle ':prompt:pure:git:stash' show yes
zstyle ':prompt:pure:git:branch' color cyan
zstyle ':prompt:pure:git:action' color yellow
zstyle ':prompt:pure:git:dirty' color red
zstyle ':prompt:pure:git:arrow' color green

# =============================================================================
# System Resource Management
# =============================================================================
# These settings help manage system resources and prevent performance issues.
# =============================================================================
ulimit -S -c 0          # Disable core dumps
setopt NO_BEEP          # Disable beeps
setopt NO_HUP           # Don't send HUP signal to background jobs on exit
setopt NO_CHECK_JOBS    # Don't report on jobs when shell exit

# Enable profiling if ZSH_PROFILE is set
if [[ -n "$ZSH_PROFILE" ]]; then
    zmodload zsh/zprof
fi

# Optimize completion system
# zstyle ':completion:*' use-cache on
# zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump"
# zstyle ':completion:*' menu select
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Optimize prompt
setopt PROMPT_SUBST          # Enable prompt substitution
setopt PROMPT_CR             # Add carriage return before prompt
setopt PROMPT_SP             # Add spaces after prompt 