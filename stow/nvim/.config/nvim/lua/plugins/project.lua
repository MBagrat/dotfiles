return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  config = function()
    require("project_nvim").setup({
      active = true,
      on_config_done = nil,
      manual_mode = false,
      detection_methods = { "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml" },
      ignore_lsp = {},
      exclude_dirs = {},
      show_hidden = false,
      silent_chdir = true,
      scope_chdir = "global",
    })

    -- setup vim mapping
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_set_keymap
    keymap("n", "<c-p>", "<CMD>lua require('telescope').extensions.projects.projects()<CR>", opts)

    -- setup which-key mapping
    local wk = require("which-key")
    wk.add({
      {
        "<leader>p",
        "<CMD>lua require('telescope').extensions.projects.projects()<CR>",
        desc = "Peojects",
        mode = "n",
      },
    })
  end,
}
