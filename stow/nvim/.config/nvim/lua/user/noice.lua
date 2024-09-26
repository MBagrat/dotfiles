-- Short description: Noice is a plugin that provides a lot of useful features for working with notifications.
-- Github repository: folke/noice.nvim
local M = {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}

function M.config()
	require("noice").setup({
		colors = {
			bg = "#1e1e1e",
			fg = "#d4d4d4",
			border = "#1e1e1e",
			header = "#1e1e1e",
			info = "#1e1e1e",
			warning = "#1e1e1e",
			error = "#1e1e1e",
			success = "#1e1e1e",
		},
		icons = {
			error = "",
			warning = "",
			info = "",
			success = "",
		},
		border = {
			chars = {
				TOP_LEFT = "┌",
				TOP_RIGHT = "┐",
				MID_HORIZONTAL = "─",
				MID_VERTICAL = "│",
				BOTTOM_LEFT = "└",
				BOTTOM_RIGHT = "┘",
			},
			style = "single",
		},
		position = "bottom",
		width = 0.5,
		height = 0.5,
		mode = "editor",
		margin = 5,
		keymap = {
			close = { "q", "<Esc>" },
			next = { "j", "<Down>" },
			prev = { "k", "<Up>" },
		},
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
		},
		presets = {
			bottom_search = false,
			command_palette = true,
			long_message_to_split = true,
		},
	})
end

return M
