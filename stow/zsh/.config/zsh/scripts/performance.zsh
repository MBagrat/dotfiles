#!/bin/sh

# =============================================================================
# Performance Optimization
# =============================================================================
# This script contains settings and configurations to optimize Zsh performance.
# It includes settings for prompt rendering, system resources, and other
# performance-critical aspects of the shell.
# =============================================================================

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

# Optimize prompt
setopt PROMPT_SUBST          # Enable prompt substitution
setopt PROMPT_CR             # Add carriage return before prompt
setopt PROMPT_SP             # Add spaces after prompt 