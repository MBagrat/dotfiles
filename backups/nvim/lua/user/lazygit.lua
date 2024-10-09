local M = {
	"kdheepak/lazygit.nvim",
	-- optional for floating window border decoration
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}

function M.config()
	local wk = require("which-key")
	wk.add({
		{ "<leader>gg", "<cmd>LazyGit<CR>", desc = "Lazy Git" },
	})
end

return M
