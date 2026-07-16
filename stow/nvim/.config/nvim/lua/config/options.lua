-- Only deviations from LazyVim / Neovim defaults live here.
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.opt.cmdheight = 0
vim.opt.scrolloff = 10 -- LazyVim: 4
vim.opt.title = true
vim.opt.breakindent = true
vim.opt.inccommand = "split" -- LazyVim: "nosplit"
vim.opt.splitkeep = "cursor" -- LazyVim: "screen"
vim.opt.mouse = "nicr" -- LazyVim: "a" (no mouse in visual mode)

vim.opt.colorcolumn = "120"
vim.opt.textwidth = 120

vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })

-- Providers

-- Disable providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Node.js provider (nodenv) — the shim avoids forking `nodenv prefix` on
-- every startup
local node_host = vim.fn.expand("$HOME") .. "/.anyenv/envs/nodenv/shims/neovim-node-host"
if vim.fn.executable(node_host) == 1 then
  vim.g.node_host_prog = node_host
else
  vim.g.loaded_node_provider = 0
end

-- Python provider (pyenv)
local py_host = vim.fn.expand("$HOME") .. "/.anyenv/envs/pyenv/shims/python"
if vim.fn.executable(py_host) == 1 then
  vim.g.python3_host_prog = py_host
else
  vim.g.loaded_python3_provider = 0
end
