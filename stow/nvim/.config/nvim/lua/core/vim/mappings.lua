local map = vim.keymap.set

-- Navigate vim panes better
-- map('n', '<c-k>', ':wincmd k<CR>')
-- map('n', '<c-j>', ':wincmd j<CR>')
-- map('n', '<c-h>', ':wincmd h<CR>')
-- map('n', '<c-l>', ':wincmd l<CR>')
--
-- map('n', '<leader>h', ':nohlsearch<CR>')

map('i', '<C-b>', '<ESC>^', { desc = 'Move Beginning of line' })
map('i', '<C-e>', '<ESC>$', { desc = 'Move End of line' })
map('i', '<C-h>', '<Left>', { desc = 'Move Left' })
map('i', '<C-l>', '<Right>', { desc = 'Move Right' })
map('i', '<C-j>', '<Down>', { desc = 'Move Down' })
map('i', '<C-k>', '<Up>', { desc = 'Move Up' })

map('n', '<Esc>', '<cmd>noh<CR>', { desc = 'General Clear highlights' })

map('n', '<C-h>', '<C-w>h', { desc = 'Switch Window left' })
map('n', '<C-l>', '<C-w>l', { desc = 'Switch Window right' })
map('n', '<C-j>', '<C-w>j', { desc = 'Switch Window down' })
map('n', '<C-k>', '<C-w>k', { desc = 'Switch Window up' })

map('n', '<C-s>', '<cmd>w<CR>', { desc = 'File Save' })
map('n', '<C-c>', '<cmd>%y+<CR>', { desc = 'File Copy whole' })

map('n', '<leader>fm', function()
  require('conform').format { lsp_fallback = true }
end, { desc = 'Format Files' })

-- global lsp mappings
map('n', '<leader>lf', vim.diagnostic.open_float, { desc = 'Lsp floating diagnostics' })
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Lsp prev diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Lsp next diagnostic' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Lsp diagnostic loclist' })

-- nvimtree
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = 'Nvimtree Toggle window' })
map('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', { desc = 'Nvimtree Focus window' })

-- whichkey
map('n', '<leader>wK', '<cmd>WhichKey <CR>', { desc = 'Whichkey all keymaps' })
map('n', '<leader>wk', function()
  vim.cmd('WhichKey ' .. vim.fn.input 'WhichKey: ')
end, { desc = 'Whichkey query lookup' })

-- Comment
map('n', '<leader>/', function()
  require('Comment.api').toggle.linewise.current()
end, { desc = 'Comment Toggle' })

map('v', '<leader>/', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Comment Toggle' })

map('n', '<leader>nl', function()
  require('noice').cmd('last')
end, { desc = 'Noice last'})

map('n', '<leader>nh', function()
  require('noice').cmd('history')
end, { desc = 'Noice history'})
