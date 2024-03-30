-- Short description: Breadcrumbs is a plugin that shows the current location in the file. It is similar to the breadcrumbs in an IDE.
-- Github repository: LunarVim/breadcrumbs.nvim
local M = {
  "LunarVim/breadcrumbs.nvim",
}

function M.config()
  require("breadcrumbs").setup()
end

return M
