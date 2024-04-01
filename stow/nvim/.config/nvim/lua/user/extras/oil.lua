-- Short description: Oil is a plugin that provides a command to open the parent directory of the current file.
-- Github repository: stevearc/oil.nvim
local M = {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
  require("oil").setup {
    float = {
      max_height = 20,
      max_width = 60,
    },
  }
  vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
end

return M
