-- Short description: Which-key is a plugin that shows keybindings in a popup.
-- Github repository: folke/which-key.nvim
local M = {
	"folke/which-key.nvim",
	dependencies = {
		{ "echasnovski/mini.icons" },
		{ "nvim-tree/nvim-web-devicons" },
	},
	event = "VeryLazy",
}

function M.config()
	local wk = require("which-key")
	wk.setup({
    preset = "modern",
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = false,
				nav = false,
				z = false,
				g = false,
			},
		},
		win = {
			border = "rounded",
			padding = { 2, 2 },
		},
		show_help = false,
		show_keys = false,
		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},
	})

	local mappings = {
		{ "<leader>;", "<cmd>tabnew | terminal<CR>", desc = "Term" },
		{ "<leader>a", group = "Tab" },
		{ "<leader>aN", "<cmd>tabnew %<cr>", desc = "New Tab" },
		{ "<leader>ah", "<cmd>-tabmove<cr>", desc = "Move Left" },
		{ "<leader>al", "<cmd>+tabmove<cr>", desc = "Move Right" },
		{ "<leader>an", "<cmd>$tabnew<cr>", desc = "New Empty Tab" },
		{ "<leader>ao", "<cmd>tabonly<cr>", desc = "Only" },
		{ "<leader>d", group = "Debug" },
		{ "<leader>h", "<cmd>nohlsearch<CR>", desc = "NOHL" },
		{ "<leader>p", group = "Plugins" },
		{ "<leader>q", group = "Quit" },
		{ "<leader>qa", "<cmd>confirm wqa<CR>", desc = "Write Quit All" },
		{ "<leader>qq", "<cmd>confirm q<CR>", desc = "Quit" },
		{ "<leader>qw", "<cmd>confirm wq<CR>", desc = "Write Quit" },
		{ "<leader>t", group = "Test" },
		{ "<leader>v", "<cmd>vsplit<CR>", desc = "Split" },
	}

	wk.add(mappings)
end

return M
