return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "tokyonight-night" },
  },
  -- Configure LazyVim to load tokyonight-night
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
