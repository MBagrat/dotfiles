-- Branch review and PR workflow on top of gitsigns/lazygit: diffview for
-- whole-branch diffs and merge conflicts, octo for GitHub PR review (needs
-- the gh CLI authenticated)
return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview (working tree)" },
      { "<leader>gV", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (Diffview)" },
    },
    opts = {},
  },
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
    keys = {
      { "<leader>gp", "<cmd>Octo pr list<cr>", desc = "Pull requests (Octo)" },
    },
    opts = {
      picker = "fzf-lua",
    },
  },
}
