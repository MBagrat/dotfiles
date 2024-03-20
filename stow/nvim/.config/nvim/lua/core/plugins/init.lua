require("lazy").setup({

  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  { 'nvim-lualine/lualine.nvim' },
  { 'nvim-tree/nvim-tree.lua' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'folke/which-key.nvim' },
  { 'nvim-treesitter/nvim-treesitter' },
  { 'lewis6991/gitsigns.nvim' },
  { 'numToStr/Comment.nvim' },
  { 'stevearc/conform.nvim' },

  -- lsps
  {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  },

  -- compilation 
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'rafamadriz/friendly-snippets' },

  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
  },
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
})

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup lazy_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | Lazy sync
  augroup end
]]
