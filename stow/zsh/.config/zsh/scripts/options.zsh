#!/bin/sh

# =============================================================================
# Zsh Options Configuration
# =============================================================================
# This script configures various Zsh options to enhance the shell experience.
# Options are organized into categories for better maintainability and clarity.
# =============================================================================

# =============================================================================
# History Options
# =============================================================================
# These options control how command history is managed and stored.
# =============================================================================
setopt HIST_IGNORE_ALL_DUPS  # Remove older duplicate entries from history
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from history items
setopt INC_APPEND_HISTORY    # Add commands as they are typed, not at shell exit
setopt SHARE_HISTORY         # Share history between all sessions
setopt HIST_IGNORE_SPACE     # Don't store commands starting with space

# =============================================================================
# Directory Navigation Options
# =============================================================================
# These options control how directory navigation and path expansion work.
# =============================================================================
setopt AUTO_CD              # Change to directory without typing cd
setopt AUTO_PUSHD           # Make cd push the old directory onto the directory stack
setopt PUSHD_IGNORE_DUPS    # Don't push multiple copies of the same directory
setopt PUSHD_SILENT         # Don't print the directory stack after pushd or popd
setopt CORRECT              # Try to correct the spelling of commands
setopt CDABLE_VARS          # Change directory to a path stored in a variable

# =============================================================================
# Path and Parameter Options
# =============================================================================
# These options control path expansion and parameter behavior.
# =============================================================================
setopt PATH_DIRS            # Perform path search even on command names with slashes
setopt AUTO_PARAM_SLASH     # If completed parameter is a directory, add a trailing slash

# =============================================================================
# Input/Output Options
# =============================================================================
# These options control how input and output are handled.
# =============================================================================
setopt NO_CLOBBER          # Prevent overwriting existing files with > and >>
setopt INTERACTIVE_COMMENTS # Allow comments in interactive shell
setopt PRINT_EXIT_VALUE     # Print exit value if non-zero
setopt RM_STAR_SILENT       # Don't ask for confirmation on 'rm *' or 'rm path/*'
setopt SUN_KEYBOARD_HACK    # Fix for SunOS keyboard