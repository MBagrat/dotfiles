-- Short description: Treesitter provides syntax highlighting and indentation for neovim. It is a parser generator tool and an incremental parsing library.
-- Github repository: nvim-treesitter/nvim-treesitter
local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup ({
    sesensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python", "yaml", "ruby" },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      use_languagetree = false,
      disable = function(_, bufnr)
        local buf_name = vim.api.nvim_buf_get_name(bufnr)
        local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
        return file_size > 256 * 1024
      end,
    },
    indent = { enable = true },
  })
end

return M
