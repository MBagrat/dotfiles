#!/bin/zsh

# =============================================================================
# Terminal.app Session State
# =============================================================================
# /etc/zshrc_Apple_Terminal hardcodes SHELL_SESSION_DIR to
# "${ZDOTDIR:-$HOME}/.zsh_sessions" before this runs. Relocate it into the
# XDG cache dir, mirroring history.zsh's HISTFILE placement.
# =============================================================================

if [[ -n "$SHELL_SESSION_DIR" ]]; then
    SHELL_SESSION_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/sessions"
    mkdir -m 700 -p "$SHELL_SESSION_DIR"
    SHELL_SESSION_FILE="$SHELL_SESSION_DIR/$TERM_SESSION_ID.session"
    SHELL_SESSION_HISTFILE="$SHELL_SESSION_DIR/$TERM_SESSION_ID.history"
    SHELL_SESSION_HISTFILE_NEW="$SHELL_SESSION_DIR/$TERM_SESSION_ID.historynew"
    SHELL_SESSION_TIMESTAMP_FILE="$SHELL_SESSION_DIR/_expiration_check_timestamp"
fi
