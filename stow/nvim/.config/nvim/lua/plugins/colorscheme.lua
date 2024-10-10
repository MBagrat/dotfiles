return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "tokyonight-night" },
  },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
