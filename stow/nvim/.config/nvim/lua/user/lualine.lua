local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "AndreM222/copilot-lualine",
  },
}

function M.config()
  require("lualine").setup {
    options = {
      theme = 'auto',
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      ignore_focus = { "NvimTree" },
    },
    sections = {
      lualine_a = { },
      lualine_b = { "branch", "diff" },
      lualine_c = { "diagnostics" },
      lualine_x = {
        "copilot",
        "filetype",
        "noice",
      },
      lualine_y = { "progress" },
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {}
    },
    extensions = { "quickfix", "man", "fugitive" },
  }
end

return M
