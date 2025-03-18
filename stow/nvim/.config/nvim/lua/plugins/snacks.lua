return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      enabled = true, -- Enable the explorer module
      replace_netrw = true, -- Replace netrw with snacks.nvim's explorer
    },
    picker = {
      sources = {
        files = {
          hidden = true,
          ignore = true,
        },
        explorer = {
          hidden = true, -- Show hidden files (dotfiles)
          ignore = true, -- Do not ignore files in .gitignore or other ignore settings
        },
      },
    },
  },
}
