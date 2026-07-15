# nvim — suggestions

Config: `stow/nvim/.config/nvim/` (NVIM 0.12.4, LazyVim)

## 1. `obsidian.nvim` upstream is archived — switch to the community fork

`epwalsh/obsidian.nvim` was archived in early 2025 and no longer receives
fixes. The maintained community fork is a drop-in replacement:

```lua
-- lua/plugins/obsidian.lua
return {
  "obsidian-nvim/obsidian.nvim",
  ...
}
```

While there, the large commented-out `event = { "BufReadPre ..." }` block
copied from the README can go — `ft = "markdown"` is the chosen strategy.

## 2. `options.lua` mostly restates LazyVim defaults — trim to deviations

LazyVim already sets (see `lazyvim/config/options.lua`): `number`,
`autoindent`/`smartindent`, `expandtab`, `shiftwidth=2`, `tabstop=2`,
`ignorecase`, `inccommand`, `splitbelow`, `splitright`, `splitkeep`,
`laststatus=3`, `smarttab`, and `vim.g.mapleader = " "`. Nvim itself defaults
`hlsearch=on`, `backspace=indent,eol,start`, `encoding=utf-8`, `backup=off`,
`showcmd=on`.

That leaves the actual intentional deviations, which is all the file needs:

```lua
vim.opt.cmdheight = 0
vim.opt.scrolloff = 10
vim.opt.wrap = false
vim.opt.title = true
vim.opt.breakindent = true
vim.opt.colorcolumn = "120"
vim.opt.textwidth = 120
vim.opt.mouse = "nicr"
vim.opt.formatoptions:append({ "r" })
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })
-- provider config below
```

A 15-line file where every line is a deliberate choice is far more useful in
two years than one where you have to guess which lines matter. (Note
`fileencoding` is buffer-local — setting it globally via `vim.opt` only
affects the sessions's default anyway.)

## 3. Provider setup: startup cost + missing guard symmetry

```lua
vim.g.node_host_prog = vim.fn.expand(vim.fn.system("nodenv prefix"):gsub("\n", "") .. "/bin/neovim-node-host")
```

- `vim.fn.system("nodenv prefix")` forks a shell **on every nvim startup**
  (typically 20–50 ms with anyenv shims). The prefix only changes when you
  switch global node versions — hardcode it or cache it:

  ```lua
  local node_prefix = vim.env.HOME .. "/.anyenv/envs/nodenv/versions/<ver>"  -- or read once & cache
  ```

  A cheap middle ground with no fork: point at the anyenv shim directly, same
  as the python provider does.

- The python provider got no guard: if the pyenv shim doesn't exist,
  `python3_host_prog` points at a dead path and `:checkhealth provider` will
  complain. Mirror the node pattern:

  ```lua
  local py = vim.fn.expand("$HOME") .. "/.anyenv/envs/pyenv/shims/python"
  if vim.fn.executable(py) == 1 then
    vim.g.python3_host_prog = py
  else
    vim.g.loaded_python3_provider = 0
  end
  ```

## 4. `treesitter.lua` is a no-op — delete it

LazyVim already ships nvim-treesitter with `highlight.enable = true`. The file
adds nothing; every spec file has a small load cost and a larger cognitive
one.

## 5. `lazyvim.json` extras audit

- `lazyvim.plugins.extras.util.chezmoi` — this repo manages dotfiles with
  **stow**, not chezmoi. The extra adds chezmoi telescope/edit integrations
  that can never be useful here. Remove.
- `lazyvim.plugins.extras.vscode` — only does anything when nvim runs
  embedded in VS Code (vscode-neovim). If you don't use that, remove.
- The 20+ language extras (`ansible`, `cmake`, `helm`, `java`, `kotlin`,
  `terraform`, `vue`, …) each pull LSP servers, treesitter parsers and Mason
  packages. Worth a pass: keep the ones you actually write, re-add others
  on demand with `:LazyExtras` (it's a two-keystroke toggle).

## 6. `wakatime` doesn't need `lazy = false`

It has no UI and only needs to hook events once you're editing:

```lua
return {
  "wakatime/vim-wakatime",
  event = "VeryLazy",
}
```

Same tracking, less startup work.

## 7. `flutter.lua`: blink capabilities are resolved too early

```lua
capabilities = (function()
  local ok, blink_cmp = pcall(require, "blink.cmp")
  ...
end)(),
```

This runs when the first `.dart` file opens. LazyVim loads blink.cmp lazily
(on `InsertEnter`), so at that moment `require("blink.cmp")` usually fails and
the Dart LSP silently starts with **empty capabilities** — no completion
capability negotiation. Make blink a dependency so it's loaded first:

```lua
dependencies = { "nvim-lua/plenary.nvim", "saghen/blink.cmp" },
```

or resolve capabilities inside `on_attach`/defer via
`LazyVim.has("blink.cmp")` patterns. Easiest correct fix is the dependency.
