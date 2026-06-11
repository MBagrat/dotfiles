# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/my-second-brain"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "Obsidian"

run_cmd "nvim"

split_h 0
run_cmd "claude"

# Set active pane.
select_pane 1
