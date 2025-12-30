return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    delay = 300,
    icons = {
      rules = false,
      breadcrumb = "» ",
      separator = "→ ",
      group = "󰹍 ",
    },
    plugins = {
      slelling = {
        enabled = false,
      },
    },
    win = {
      height = {
        max = math.huge,
      },
    },
  },
}
