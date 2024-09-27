-- Short description: Keymaps for neovim. This file contains keymaps for neovim.
-- Github repository: mbagrat/dotfiles
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- noremap description: Do not remap the right-hand side to the left-hand side.
-- silent description: Do not echo the command to the command line.
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "<Space>", "", opts)                                                                        -- desc "Clear search"
keymap("n", "<C-i>", "<C-i>", opts)                                                                     -- desc "Jump to definition"

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)                                                                    -- desc "Switch window left"
keymap("n", "<C-j>", "<C-w>j", opts)                                                                    -- desc "Switch Window down"
keymap("n", "<C-k>", "<C-w>k", opts)                                                                    -- desc "Switch Window up"
keymap("n", "<C-l>", "<C-w>l", opts)                                                                    -- desc "Switch Window right"
keymap("n", "<C-tab>", "<c-6>", opts)                                                                   -- desc "Switch to last buffer"

keymap("n", "n", "nzz", opts)                                                                           -- desc "Next search result"
keymap("n", "N", "Nzz", opts)                                                                           -- desc "Previous search result"
keymap("n", "*", "*zz", opts)                                                                           -- desc "Highlight search result"
keymap("n", "#", "#zz", opts)                                                                           -- desc "Highlight search result"
keymap("n", "g*", "g*zz", opts)                                                                         -- desc "Highlight search result"
keymap("n", "g#", "g#zz", opts)                                                                         -- desc "Highlight search result"

-- Stay in indent mode
keymap("v", "<", "<gv", opts)                                                                           -- desc "Indent left"
keymap("v", ">", ">gv", opts)                                                                           -- desc "Indent right"

keymap("x", "p", [["_dP]], opts)                                                                        -- desc "Paste without yanking"

keymap("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>", opts)                                          -- desc "Popup mousemenu"
keymap("n", "<Tab>", "<cmd>:popup mousemenu<CR>", opts)                                                 -- desc "Popup mousemenu"

-- more good
keymap({ "n", "o", "x" }, "<s-h>", "^", opts)                                                           -- desc "Move to start of line"
keymap({ "n", "o", "x" }, "<s-l>", "g_", opts)                                                          -- desc "Move to end of line"

-- tailwind bearable to work with
keymap({ "n", "x" }, "j", "gj", opts)                                                                   -- desc "Move down visual line"
keymap({ "n", "x" }, "k", "gk", opts)                                                                   -- desc "Move up visual line"
keymap("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", opts)                                -- desc "Toggle wrap"

keymap("t", "<C-;>", "<C-\\><C-n>", opts)                                                               -- desc "Exit terminal mode"

vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]              -- desc = 'Goto Definition' 
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]                    -- desc = 'References' 
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]] -- desc = '-sep-'
