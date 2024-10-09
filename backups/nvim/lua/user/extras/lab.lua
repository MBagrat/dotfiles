-- Short description: Lab.nvim is a plugin that provides a lot of useful features for working with code snippets and code execution. 
-- Github repository: 0x100101/lab.nvim
local M = {
  "0x100101/lab.nvim",
  build = "cd js && npm ci",
}

function M.config()
  require("lab").setup {
    code_runner = {
      enabled = true,
    },
    quick_data = {
      enabled = false,
    },
  }
end

return M
