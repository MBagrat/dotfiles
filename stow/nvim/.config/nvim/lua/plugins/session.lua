-- Session persistence via vim-obsession (works in Vim and Neovim alike),
-- replacing LazyVim's default persistence.nvim which is Neovim-only.
return {
  { "folke/persistence.nvim", enabled = false },
  {
    "tpope/vim-obsession",
    cmd = "Obsession",
    init = function()
      -- Session.vim is Obsession's own file convention; auto-source it on a
      -- plain `nvim` with no file args, mirroring `vim -S Session.vim`.
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 0 and vim.fn.filereadable("Session.vim") == 1 then
            vim.cmd("source Session.vim")
          end
        end,
      })
    end,
    keys = {
      { "<leader>qs", "<cmd>Obsession<cr>", desc = "Start tracking session" },
      { "<leader>qd", "<cmd>Obsession!<cr>", desc = "Stop tracking session" },
      {
        "<leader>qS",
        function()
          vim.notify(vim.g.this_obsession and ("Obsession: tracking " .. vim.g.this_obsession) or "Obsession: not tracking")
        end,
        desc = "Session status",
      },
      {
        "<leader>ql",
        function()
          if vim.fn.filereadable("Session.vim") == 1 then
            vim.cmd("source Session.vim")
          else
            vim.notify("No Session.vim in cwd", vim.log.levels.WARN)
          end
        end,
        desc = "Load Session.vim from cwd",
      },
    },
  },
}
