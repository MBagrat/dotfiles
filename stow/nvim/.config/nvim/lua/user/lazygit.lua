local M = {
  "kdheepak/lazygit.nvim",
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

function M.config()
  local wk = require "which-key"
  wk.register({
    g = {
      name = "LazyGit",
      g = { "<cmd>LazyGit<CR>", "LazyGit" },
    },
  }, { prefix = "<leader>" })
end

return M
