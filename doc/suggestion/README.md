# Config review — suggestions (2026-07-13)

Review of the nvim, tmux, tmuxifier and kitty configs. This pass builds on the
cleanup already done in `0793b8b` (escape-time, focus-events, resurrect,
provider guards, shared tmuxifier templates), so nothing from that commit is
repeated here.

One file per tool:

- [tmux.md](tmux.md)
- [nvim.md](nvim.md)
- [tmuxifier.md](tmuxifier.md)
- [kitty.md](kitty.md)

## Top 5 quick wins

1. **tmux true color never applies inside kitty** — the override targets
   `xterm-256color`, but kitty's `TERM` is `xterm-kitty`. See [tmux.md](tmux.md) #1.
2. **kitty tab bar runs `pmset` on every redraw** — a blocking subprocess in
   the render path, triggered up to once per second per tab. Cache it. See
   [kitty.md](kitty.md) #1.
3. **`obsidian.nvim` upstream is archived** — switch to the maintained
   community fork `obsidian-nvim/obsidian.nvim`. See [nvim.md](nvim.md) #1.
4. **`nvim/lua/config/options.lua` mostly restates LazyVim defaults** — trim
   it to actual deviations so it documents intent. See [nvim.md](nvim.md) #2.
5. **tmuxifier per-project window files can be folded into the session files**
   — removes 7 one-line files and their subdirectories. See
   [tmuxifier.md](tmuxifier.md) #1.
