local M = {
  "tpope/vim-fugitive"
}

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>gs"] = { "<cmd>Git<cr>", "Git status" },
    ["<leader>gd"] = { "<cmd>Gdiff<cr>", "Git diff" },
    ["<leader>gc"] = { "<cmd>Git commit<cr>", "Git commit" },
    ["<leader>gb"] = { "<cmd>Git blame<cr>", "Git blame" },
    ["<leader>gl"] = { "<cmd>Git log<cr>", "Git log" },
    ["<leader>gp"] = { "<cmd>Git push<cr>", "Git push" },
    ["<leader>gP"] = { "<cmd>Git pull<cr>", "Git pull" },
  }
end

return M
