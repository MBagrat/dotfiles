-- Short description: Load nvim-web-devicons for showing file icons in the NvimTree.
-- Github repository: nvim-tree/nvim-web-devicons
local M = {
  "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
}

function M.config()
  require "nvim-web-devicons"
end

return M
