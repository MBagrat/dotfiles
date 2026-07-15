# tmux — suggestions

Config: `stow/tmux/.config/tmux/tmux.conf` (tmux 3.7b)

## 1. True-color override doesn't match kitty (bug)

```tmux
set -g default-terminal "tmux-256color"
set -ga terminal-overrides ",xterm-256color:Tc"
```

The override only applies when the *outer* terminal's `TERM` is
`xterm-256color`. kitty sets `TERM=xterm-kitty`, so this line never matches on
your primary terminal — tmux is relying on kitty's terminfo alone. It mostly
works because `xterm-kitty` terminfo advertises RGB, but the moment tmux can't
resolve that terminfo (SSH into the box, terminfo not installed) colors
degrade silently.

Since tmux 3.2 the recommended mechanism is `terminal-features`:

```tmux
set -g default-terminal "tmux-256color"
set -as terminal-features ",xterm-kitty:RGB"
# or, if you trust every terminal you attach from:
set -as terminal-features ",*:RGB"
```

## 2. Enable passthrough for the kitty graphics protocol

Neovim plugins that render images (e.g. `snacks.image`, which LazyVim uses for
markdown/image preview) need tmux to pass kitty's graphics escapes through:

```tmux
set -g allow-passthrough on
```

Without it, image rendering inside tmux silently falls back to nothing.

## 3. Extended keys (better key disambiguation in nvim)

kitty supports the extended keyboard protocol; letting tmux forward it means
nvim can distinguish e.g. `<C-i>` from `<Tab>`, `<C-m>` from `<CR>`:

```tmux
set -g extended-keys on
set -as terminal-features ",xterm-kitty:extkeys"
```

## 4. `detach-on-destroy off` fits the multi-session workflow

With tmuxifier you routinely run several named sessions. By default, killing
the last window of a session detaches the client entirely — dropping you back
to a bare shell. With:

```tmux
set -g detach-on-destroy off
```

tmux switches to the most recently used remaining session instead, which is
almost always what you want when closing a finished project session.

## 5. Verify tmux-continuum is actually saving

`tmux-continuum` works by injecting its save hook into `status-right`.
`tokyo-night-tmux` fully rewrites the status line. Your plugin order
(theme before continuum) should make it work, but it's fragile and worth a
one-time check:

```sh
ls ~/.local/share/tmux/resurrect/   # or the tpm plugin dir's resurrect folder
tmux show-option -gv @continuum-save-interval
```

If saves aren't appearing, pin the interval explicitly and make sure continuum
stays the *last* status-line-touching plugin:

```tmux
set -g @continuum-save-interval '15'
```

## 6. Consider a popup binding for quick tools (optional)

tmux ≥ 3.2 popups are a nice fit for the nvim+claude window layout — e.g. a
floating lazygit or scratch shell that doesn't disturb the pane layout:

```tmux
bind-key g display-popup -E -w 90% -h 90% -d "#{pane_current_path}" "lazygit"
bind-key t display-popup -E -w 70% -h 70% -d "#{pane_current_path}"
```

## 7. Duplicate battery + clock across the two bars (cosmetic)

The tokyo-night tmux status bar (top) shows battery, date and time — and the
kitty tab bar (bottom) shows battery, date and time again. Since tmux runs
fullscreen inside kitty essentially always, consider dropping one of the two
(e.g. `@tokyo-night-tmux_show_battery_widget 0` and `_show_datetime 0`, or
strip the right-status from `tab_bar.py`). Also frees kitty from the `pmset`
polling described in [kitty.md](kitty.md).
