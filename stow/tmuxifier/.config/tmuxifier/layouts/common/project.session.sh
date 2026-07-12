# Shared session template: superfile window + one project window.
#
# Callers must set SESSION_NAME, SESSION_ROOT and WINDOW_PATH, then source
# this file.

# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "${SESSION_ROOT:?SESSION_ROOT must be set}"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "${SESSION_NAME:?SESSION_NAME must be set}"; then

  # Load specified window layout.
  #
  # Arguments:
  #   - $1: Name of or file path to window layout to load.
  #   - $2: (optional) Override default window name.
  #
  load_window "$TMUXIFIER_LAYOUT_PATH/common/superfile.window.sh"
  load_window "$TMUXIFIER_LAYOUT_PATH/${WINDOW_PATH:?WINDOW_PATH must be set}"

  # Select a specific window.
  #
  # Arguments:
  #   - $1: Window ID or name to select.
  #
  select_window 2

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
