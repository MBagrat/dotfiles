# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "$HOME/Workspace/personal/projects/alfred/kill-process"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "Kill Process"

run_cmd "nvim"

split_h 30

run_cmd "claude"

# Set active pane.
select_pane 1
