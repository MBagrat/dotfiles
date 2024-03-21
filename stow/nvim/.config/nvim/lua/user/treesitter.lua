local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup ({
    sesensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python", "yaml", "ruby" },
    highlight = { enable = true },
    indent = { enable = true },
  })
end

return M
