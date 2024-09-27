-- Short description: Cellular Automaton in Neovim with Lua and Fennel supports
-- Github repository: eandrju/cellular-automaton.nvim
local M = {
  "eandrju/cellular-automaton.nvim",
}

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>y"] = { "<cmd>CellularAutomaton<CR>", "Cellular Automaton" },
  }
end

return M
