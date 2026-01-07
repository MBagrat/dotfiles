vim.g.mapleader = " "

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"
vim.opt.mouse = "nicr"

vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- Providers

-- Disable providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Node.js provider (nodenv)
vim.g.node_host_prog = vim.fn.expand(vim.fn.system("nodenv prefix"):gsub("\n", "") .. "/bin/neovim-node-host")

-- Python provider (pyenv)
vim.g.python3_host_prog = vim.fn.expand("$HOME") .. "/.anyenv/envs/pyenv/shims/python"
