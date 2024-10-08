--  Short description: Mason is a plugin that installs and configures LSP servers.
-- Github repository: williamboman/mason-lspconfig.nvim
local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}

function M.config()
  local servers = {
    "lua_ls",
    "cssls",
    "eslint",
    "html",
    "ts_ls",
    "pyright",
    "bashls",
    "jsonls",
    "yamlls",
    "zk",
  }

  require("mason").setup {
    ui = {
      border = "rounded",
    },
  }

  require("mason-lspconfig").setup {
    ensure_installed = servers,
  }
end

return M
