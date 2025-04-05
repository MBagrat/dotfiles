#!/bin/sh

# =============================================================================
# Keybindings Configuration
# =============================================================================
# This script configures keyboard shortcuts and keybindings for Zsh.
# It includes both emacs and vi mode keybindings, as well as custom
# keybindings for specific functionality.
# =============================================================================

# =============================================================================
# Keybinding Mode
# =============================================================================
# Set the keybinding mode (emacs or vi)
# =============================================================================
bindkey -e  # Use emacs keybindings by default

# =============================================================================
# Custom Keybindings
# =============================================================================
# Define custom keybindings for specific functionality
# =============================================================================
bindkey '^[[A' history-substring-search-up    # Up arrow for history search
bindkey '^[[B' history-substring-search-down  # Down arrow for history search
bindkey '^R' history-incremental-search-backward  # Ctrl+R for reverse history search
