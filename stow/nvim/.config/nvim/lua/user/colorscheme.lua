-- Short description: Load the tokyonight color scheme. This is a dark color scheme. It comes in three styles: storm, moon, and night.
-- Github repository: folke/tokyonight.nvim
local M = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
}

function M.config()
  -- there are four styles on tokyonight theme: storm, moon, night and day
  vim.cmd[[colorscheme tokyonight-night]]

  require("tokyonight").setup {
    style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    light_style = "day",
    transparent = true,
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
    styles = {
      comments = { italic = true },
      keywords = { italic = false },
      functions = {},
      variables = {},
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = "transparent",
      floats = "transparent",
    },
    sidebars = { "qf", "help" },
    day_brightness = 0.3,
    hide_inactive_statusline = false,
    dim_inactive = false,
    lualine_bold = false,

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    on_colors = function() end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors) end,
  }
end

return M
