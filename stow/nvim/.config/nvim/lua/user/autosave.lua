-- Short description: Autosave files on InsertLeave and TextChanged events
-- Github repository: pocco81/auto-save.nvim
local M = {
  "Pocco81/auto-save.nvim",
}

function M.config()
  require("auto-save").setup {
    enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
  }
end

return M
