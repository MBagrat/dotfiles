# tmuxifier — suggestions

Config: `stow/tmuxifier/.config/tmuxifier/layouts/`

The shared-template refactor from `0793b8b` is good. These suggestions push it
one step further.

## 1. Fold the per-project window files into the session files

Every per-project window file is now just two variables plus a `source`:

```sh
# learning/learning.window.sh
WINDOW_ROOT="$HOME/Workspace/personal/projects/learning"
WINDOW_TITLE="Learning"
source "$TMUXIFIER_LAYOUT_PATH/common/nvim-claude.window.sh"
```

Since `common/project.session.sh` controls which windows get loaded anyway, it
can load `common/nvim-claude.window.sh` directly and let the session file set
all four variables:

```sh
# learning.session.sh — the only file per project
SESSION_NAME="Learning"
SESSION_ROOT="$HOME/Workspace/personal/projects"
WINDOW_ROOT="$SESSION_ROOT/learning"
WINDOW_TITLE="Learning"
source "$TMUXIFIER_LAYOUT_PATH/common/project.session.sh"
```

with `project.session.sh` changed to:

```sh
load_window "$TMUXIFIER_LAYOUT_PATH/common/superfile.window.sh"
load_window "$TMUXIFIER_LAYOUT_PATH/common/nvim-claude.window.sh" "$WINDOW_TITLE"
```

That deletes 7 one-line window files and 7 subdirectories, and each project
becomes a single 5-line file. `WINDOW_PATH` stays available as an escape hatch
for a future project that needs a genuinely custom window
(`load_window "${WINDOW_PATH:-common/nvim-claude.window.sh}"`).

## 2. Root the Superfile window at the project, not `$HOME`

`common/superfile.window.sh` hardcodes `window_root "$HOME"`, so in the
Dotfiles session the file manager opens at `~`, in the Learning session at
`~`, etc. Rooting it at the session makes the window actually belong to the
project:

```sh
window_root "${SESSION_ROOT:-$HOME}"
```

(or `WINDOW_ROOT` if you fold the windows per #1 — then superfile opens right
at the project directory.)

## 3. Deduplicate the Obsidian vault path

The iCloud vault path appears verbatim in two places:

- `layouts/obsidian/obsidian.window.sh`
- `nvim/lua/plugins/obsidian.lua`

Export it once from zsh (which both tmuxifier layouts and nvim inherit):

```sh
# zsh env
export OBSIDIAN_VAULT="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/my-second-brain"
```

then `WINDOW_ROOT="$OBSIDIAN_VAULT"` and in Lua
`path = vim.env.OBSIDIAN_VAULT or (vim.fn.expand("~") .. "/Library/...")`.
When the vault moves, one edit instead of a repo-wide grep.

## 4. Trailing-slash consistency (nit)

`dotfiles.session.sh` uses `SESSION_ROOT="$HOME/"`; every other layout omits
the trailing slash. Harmless, but it's the kind of thing that produces
`~//.dotfiles`-style paths in status bars. Drop the slash.
