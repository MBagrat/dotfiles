-- Toggle one-line <-> multi-line for argument lists, builder chains and
-- annotations
return {
  "Wansmer/treesj",
  keys = {
    { "<leader>cj", "<cmd>TSJToggle<cr>", desc = "Split/Join toggle" },
  },
  opts = {
    use_default_keymaps = false,
    max_join_length = 150,
  },
}
