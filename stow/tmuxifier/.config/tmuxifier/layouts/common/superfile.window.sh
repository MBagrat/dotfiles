# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
# Open the file manager at the project directory rather than $HOME.
window_root "${WINDOW_ROOT:-${SESSION_ROOT:-$HOME}}"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "Superfile"

run_cmd "spf"

# Set active pane.
select_pane 1
