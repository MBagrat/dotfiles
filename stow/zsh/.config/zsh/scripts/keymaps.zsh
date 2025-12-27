#!/bin/zsh

# =============================================================================
# ZSH Keymaps Configuration
# =============================================================================
# This file configures custom keybindings for zsh shell
# It should be sourced after plugins are loaded in .zshrc

# =============================================================================
# Word Style Configuration
# =============================================================================
# Configure what constitutes a "word" for word-based navigation
# Options: 'normal', 'bash', 'shell', 'whitespace'
# - normal: treats special chars (/, -, ., etc.) as word separators
# - bash: treats paths as single words (better for file paths)
# - shell: similar to bash, shell-friendly word boundaries
# - whitespace: only whitespace separates words
autoload -U select-word-style
select-word-style bash

# Alternative: Manually set WORDCHARS to control word boundaries
# Uncomment and customize if you want fine-grained control
# WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'

# =============================================================================
# Custom Keybindings
# =============================================================================
# Define custom keybindings for specific functionality

# History search (currently disabled - uncomment if needed)
bindkey '^[[A' history-substring-search-up    # Up arrow for history search
bindkey '^[[B' history-substring-search-down  # Down arrow for history search
bindkey '^R' history-incremental-search-backward  # Ctrl+R for reverse history search

# =============================================================================
# Word Navigation - Option/Alt + Arrow Keys
# =============================================================================
# Multiple bindings for compatibility across different terminal configurations

# Emacs-style sequences (common in iTerm2 default config)
bindkey '^[f' forward-word          # Option+Right (emacs-style)
bindkey '^[b' backward-word         # Option+Left (emacs-style)

# ANSI standard escape sequences
bindkey '^[[1;3C' forward-word      # Option+Right (ANSI)
bindkey '^[[1;3D' backward-word     # Option+Left (ANSI)

# =============================================================================
# Word Navigation - Ctrl + Arrow Keys
# =============================================================================
bindkey '^[[1;5C' forward-word      # Ctrl+Right
bindkey '^[[1;5D' backward-word     # Ctrl+Left

# =============================================================================
# Additional Useful Keybindings (optional - uncomment to enable)
# =============================================================================

# Delete word backward/forward
# bindkey '^[^?' backward-kill-word   # Option+Backspace
# bindkey '^[[3;3~' kill-word         # Option+Delete

# Home/End keys
# bindkey '^[[H' beginning-of-line    # Home
# bindkey '^[[F' end-of-line          # End

# Delete key
# bindkey '^[[3~' delete-char         # Delete
