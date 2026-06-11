# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "$HOME/Workspace/personal/projects/local-services"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "Services"

run_cmd "nvim"

# Set active pane.
select_pane 1
