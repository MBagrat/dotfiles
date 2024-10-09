-- Short description: Eyeliner is a plugin that highlights the key you just pressed
-- GitHub repository: jinh0/eyeliner.nvim
local M = {
  "jinh0/eyeliner.nvim",
  event = "VeryLazy",
}

function M.config()
  require("eyeliner").setup {
    highlight_on_key = true,
  }
end

return M
