# Shared window template: nvim + claude split.
#
# Callers must set WINDOW_ROOT and WINDOW_TITLE, then source this file.
# SPLIT_PCT is optional and defaults to 30.

window_root "${WINDOW_ROOT:?WINDOW_ROOT must be set}"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "${WINDOW_TITLE:?WINDOW_TITLE must be set}"

run_cmd "nvim"

split_h "${SPLIT_PCT:-30}"

run_cmd "claude"

# Set active pane.
select_pane 1
