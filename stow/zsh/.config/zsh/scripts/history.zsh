#!/bin/sh

# =============================================================================
# History Configuration
# =============================================================================
# This script configures the Zsh history system, controlling how command history
# is stored, retrieved, and managed. It works in conjunction with the history
# options set in options.zsh to provide a comprehensive history management system.
# =============================================================================

# =============================================================================
# History File Configuration
# =============================================================================
# These variables control where and how history is stored.
# =============================================================================
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history/zsh_history"  # History file location
HISTSIZE=10000                                                      # Number of commands to keep in memory
SAVEHIST=10000                                                      # Number of commands to save to file

# =============================================================================
# History Search Configuration
# =============================================================================
# These variables control how history search works.
# =============================================================================
HISTORY_IGNORE="(ls|cd|pwd|exit|cd ..|cd -)"  # Commands to ignore in history
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=green,fg=black,bold"  # Highlight found matches
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=red,fg=black,bold"  # Highlight not found matches

# # History options
setopt EXTENDED_HISTORY       # Record timestamp of command in HISTFILE
setopt HIST_IGNORE_SPACE      # Don't save commands that start with space
setopt HIST_IGNORE_DUPS       # Don't save duplicate commands
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicate entries
setopt HIST_FIND_NO_DUPS      # Don't show duplicates when searching
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks
setopt HIST_VERIFY            # Show command with history expansion before executing
setopt SHARE_HISTORY          # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST # Delete duplicates first when HISTFILE size exceeds HISTSIZE