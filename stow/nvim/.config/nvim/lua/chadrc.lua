local M = {}

-- pick a random dashboard header
local header = require("headers")["random"]

M.ui = {
	theme_toggle = { "tokyonight", "catppuccin" },
	theme = "catppuccin",
	nvdash = {
		load_on_startup = true,
		header = header,
		buttons = {
			{ "  Find File", "⌴ f f", "Telescope find_files" },
			{ "  Recent Files", "⌴ f o", "Telescope oldfiles" },
			{ "  Find Word", "⌴ f w", "Telescope live_grep" },
			{ "  Bookmarks", "⌴ b m", "Telescope marks" },
			{ "  Themes", "⌴ t h", "Telescope themes" },
			{ "  Mappings", "⌴ c h", "NvCheatsheet" },
			{ "  Quit", "⌴ q ⌴", "quit" },
		},
	},
}

return M
