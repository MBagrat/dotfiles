return {
  -- Maintained community fork; upstream epwalsh/obsidian.nvim is archived
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  cmd = "Obsidian",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>oo", "<cmd>Obsidian open<cr>", desc = "Open in Obsidian app", ft = "markdown" },
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New note" },
    { "<leader>oN", "<cmd>Obsidian new_from_template<cr>", desc = "New note from template" },
    { "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Quick switch note" },
    { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search notes" },
    { "<leader>ot", "<cmd>Obsidian tags<cr>", desc = "Search tags" },
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Backlinks", ft = "markdown" },
    { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "Links in note", ft = "markdown" },
    { "<leader>od", "<cmd>Obsidian today<cr>", desc = "Daily note (today)" },
    { "<leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "Daily note (yesterday)" },
    { "<leader>oD", "<cmd>Obsidian dailies<cr>", desc = "Browse daily notes" },
    { "<leader>oT", "<cmd>Obsidian template<cr>", desc = "Insert template", ft = "markdown" },
    { "<leader>op", "<cmd>Obsidian paste_img<cr>", desc = "Paste image", ft = "markdown" },
    { "<leader>or", "<cmd>Obsidian rename<cr>", desc = "Rename note (update links)", ft = "markdown" },
    { "<leader>oc", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Toggle checkbox", ft = "markdown" },
    { "<leader>ox", "<cmd>Obsidian extract_note<cr>", mode = "v", desc = "Extract selection to note", ft = "markdown" },
    { "<leader>ok", "<cmd>Obsidian link<cr>", mode = "v", desc = "Link selection to existing note", ft = "markdown" },
    { "<leader>oK", "<cmd>Obsidian link_new<cr>", mode = "v", desc = "Link selection to new note", ft = "markdown" },
  },
  opts = {
    -- Use the new `:Obsidian <cmd>` subcommands; legacy :ObsidianToday-style
    -- commands are removed in v4.0
    legacy_commands = false,
    workspaces = {
      {
        name = "my-second-brain",
        path = vim.env.OBSIDIAN_VAULT or (vim.fn.expand("~") .. "/Workspace/personal/obsidian/my-second-brain"),
      },
    },

    -- Vault notes are named by their literal title (e.g. Budapest.md), not
    -- zettel-timestamped, so keep that convention for new notes
    note_id_func = function(title)
      if title and title ~= "" then
        return title
      end
      -- untitled notes fall back to a zettel-style timestamp id
      return require("obsidian.builtin").zettel_id()
    end,

    -- Daily notes live in the vault root as YYYY-MM-DD.md (Obsidian app default)
    daily_notes = {
      date_format = "YYYY-MM-DD",
      default_tags = { "daily-notes" },
      workdays_only = false,
    },

    -- Mirrors .obsidian/templates.json; the folder is created on first load
    templates = {
      folder = "meta/templates",
      date_format = "DD-MM-YYYY",
      time_format = "HH:mm",
    },

    -- Pasted images (<leader>op, needs pngpaste) go here, relative to vault
    -- root; snacks.image resolves them for inline preview in kitty
    attachments = {
      folder = "attachments",
    },
  },
}
