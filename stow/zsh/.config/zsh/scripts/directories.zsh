#!/bin/zsh

# =============================================================================
# Directory Configuration
# =============================================================================
# This script sets up essential directory paths for the Zsh configuration.
# It ensures that all necessary directories exist and are properly configured
# for the shell environment.
# =============================================================================

# Create necessary directories if they don't exist
[[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ]] || mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d "${XDG_DATA_HOME:-$HOME/.local/share}/zsh" ]] || mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
# Create all necessary zsh directories
[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history/" ] || mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history/"
[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump/" ] || mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump/"
[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compiled/" ] || mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compiled/" 