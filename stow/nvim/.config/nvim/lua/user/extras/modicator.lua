-- Short description: Modicator is a plugin that shows the current mode in the statusline.
-- Github repository: mawkler/modicator.nvim
local M = {
  "mawkler/modicator.nvim",
  event = "BufEnter",
}

function M.config()
  require("modicator").setup {
    show_warnings = false,
    highlights = {
      defaults = {
        bold = true,
        italic = false,
      },
    },
  }

  vim.api.nvim_create_autocmd({ "Colorscheme" }, {
    callback = function()
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#388bfd", bg = "NONE" })
    end,
  })
end

return M
