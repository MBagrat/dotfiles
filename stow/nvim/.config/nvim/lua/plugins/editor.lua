return {
  { "wakatime/vim-wakatime", lazy = false },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            "node_modules",
            ".git",
            ".idea",
            ".ruby-lsp",
          },
        },
        group_empty_dirs = true,
      },
    },
  },
  {
    "IlyasYOY/obs.nvim",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "IlyasYOY/coredor.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    lazy = true,
    cmd = {
      "ObsNvimFollowLink",
      "ObsNvimRandomNote",
      "ObsNvimNewNote",
      "ObsNvimCopyObsidianLinkToNote",
      "ObsNvimOpenInObsidian",
      "ObsNvimDailyNote",
      "ObsNvimWeeklyNote",
      "ObsNvimRename",
      "ObsNvimTemplate",
      "ObsNvimMove",
      "ObsNvimBacklinks",
      "ObsNvimFindInJournal",
      "ObsNvimFindNote",
      "ObsNvimFindInNotes",
    },
    keys = {
      { "<leader>n", desc = "Obsidian" },
      { "<leader>nn", "<cmd>ObsNvimFollowLink<cr>", desc = "Follow The Link" },
      { "<leader>nr", "<cmd>ObsNvimRandomNote<cr>", desc = "Random Note" },
      { "<leader>nN", "<cmd>ObsNvimNewNote<cr>", desc = "Obsidian New Note" },
      { "<leader>ny", "<cmd>ObsNvimCopyObsidianLinkToNote<cr>", desc = "Copy Link To Note" },
      { "<leader>no", "<cmd>ObsNvimOpenInObsidian<cr>", desc = "Open In Obsidian" },
      { "<leader>nd", "<cmd>ObsNvimDailyNote<cr>", desc = "Daily Note" },
      { "<leader>nw", "<cmd>ObsNvimWeeklyNote<cr>", desc = "Weekly Note" },
      { "<leader>nrn", "<cmd>ObsNvimRename<cr>", desc = "Rename" },
      { "<leader>nT", "<cmd>ObsNvimTemplate<cr>", desc = "Template" },
      { "<leader>nM", "<cmd>ObsNvimMove<cr>", desc = "Move" },
      { "<leader>nb", "<cmd>ObsNvimBacklinks<cr>", desc = "Backlinks" },
      { "<leader>nfj", "<cmd>ObsNvimFindInJournal<cr>", desc = "Find in Joulnal" },
      { "<leader>nff", "<cmd>ObsNvimFindNote<cr>", desc = "Find Note" },
      { "<leader>nfg", "<cmd>ObsNvimFindInNotes<cr>", desc = "Find in Notes" },
    },
    config = function()
      local obs = require("obs")
      obs.setup({
        vault_home = "/Users/mbagrat/Library/Mobile Documents/iCloud~md~obsidian/Documents/my-second-brain",
        vault_name = "My Second Brain",
        journal = {
          daily_template_name = "daily",
          weekly_template_name = "weekly",
        },
      })
      local cmp = require("cmp")
      local cmp_source = require("obs.cmp-source")
      cmp.register_source("obs", cmp_source.new())
    end,
  },
}
