return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          "node_modules",
          ".git",
          ".idea",
          ".ruby-lsp",
        },
      },
      group_empty_dirs = true,
    },
  },
}
