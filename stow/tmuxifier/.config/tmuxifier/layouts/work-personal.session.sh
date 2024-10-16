# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "$HOME/Workspace/work/personal/projects"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "work-personal"; then

  # Load specified window layout.
  #
  # Arguments:
  #   - $1: Name of or file path to window layout to load.
  #   - $2: (optional) Override default window name.
  #
  load_window "$TMUXIFIER_LAYOUT_PATH/work/personal/dotfiles.window.sh"
  load_window "$TMUXIFIER_LAYOUT_PATH/work/personal/obsidian.window.sh"
  load_window "$TMUXIFIER_LAYOUT_PATH/work/personal/learning.window.sh"
  load_window "$TMUXIFIER_LAYOUT_PATH/work/personal/nvim.window.sh"
  load_window "$TMUXIFIER_LAYOUT_PATH/work/personal/services.window.sh"
  load_window "$TMUXIFIER_LAYOUT_PATH/work/personal/website.window.sh"

  # Select a specific window.
  #
  # Arguments:
  #   - $1: Window ID or name to select.
  #
  select_window 1
  # select_window "Dotfiles"
  # select_window "Website"
  # select_window "Services"

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
