-- Short description: Breadcrumbs is a plugin that shows the current location in the file. It is similar to the breadcrumbs in an IDE.
-- Github repository: LunarVim/breadcrumbs.nvim
local M = {
  "LunarVim/breadcrumbs.nvim",
  dependencies = {
    { "SmiteshP/nvim-navic" },
  },
}

function M.config()
  require("nvim-navic").setup {
    lsp = {
      auto_attach = true,
    },
  }
  require("breadcrumbs").setup()
end

return M
