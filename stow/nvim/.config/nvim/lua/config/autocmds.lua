-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Native LSP folding (nvim-ufo replacement: ufo's promise-async collides
-- with refactoring.nvim's async.nvim — both claim the `async` lua module).
-- Falls back to LazyVim's treesitter foldexpr when the server has no
-- foldingRange support
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_folding", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      if vim.api.nvim_win_get_buf(win) == args.buf then
        vim.wo[win][0].foldmethod = "expr"
        vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
      end
    end
  end,
})
