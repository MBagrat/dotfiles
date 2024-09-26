-- Short description: Project.nvim is a plugin that provides a way to manage projects in neovim.
-- Github repository: ahmedkhalf/project.nvim
-- 
-- ####Telescope mappings
-- 
-- **project.nvim** comes with the following mappings:
-- 
-- | Normal mode | Insert mode | Action                     |
-- | ----------- | ----------- | -------------------------- |
-- | f           | \<c-f\>     | find\_project\_files       |
-- | b           | \<c-b\>     | browse\_project\_files     |
-- | d           | \<c-d\>     | delete\_project            |
-- | s           | \<c-s\>     | search\_in\_project\_files |
-- | r           | \<c-r\>     | recent\_project\_files     |
-- | w           | \<c-w\>     | change\_working\_directory |
-- 
local M = {
	"ahmedkhalf/project.nvim",
	event = "VeryLazy",
}

function M.config()
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
		{ "<leader>p", "<CMD>lua require('telescope').extensions.projects.projects()<CR>", desc="Peojects", mode = "n" },
	})
end

return M
