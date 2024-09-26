-- Short description: Treesitter provides syntax highlighting and indentation for neovim. It is a parser generator tool and an incremental parsing library.
-- Github repository: nvim-treesitter/nvim-treesitter
local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	-- cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
}

function M.config()
	require("nvim-treesitter.configs").setup({
		modules = {},
		-- List of parsers to ignore installing (or "all")
		ignore_install = {},
		-- A list of parser names, or "all" (the five listed parsers should always be installed)
		ensure_installed = {
			"angular",
			"bash",
			"css",
			"csv",
			"dart",
			"dockerfile",
			"git_config",
			"git_rebase",
			"gitattributes",
			"gitcommit",
			"gitignore",
			"gpg",
			"graphql",
			"helm",
			"html",
			"http",
			"java",
			"javascript",
			"json",
			"json5",
			"jsonc",
			"kotlin",
			"lua",
			"luadoc",
			"luap",
			"luau",
			"make",
			"markdown",
			"markdown_inline",
			"mermaid",
			"meson",
			"pod",
			"properties",
			"python",
			"regex",
			"ruby",
			"rust",
			"scala",
			"scheme",
			"solidity",
			"sql",
			"ssh_config",
			"swift",
			"tmux",
			"todotxt",
			"toml",
			"typescript",
			"vim",
			"vimdoc",
			"vue",
			"xml",
			"yaml",
		},

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,

		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
			use_languagetree = false,
			disable = function(_, bufnr)
				local buf_name = vim.api.nvim_buf_get_name(bufnr)
				local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
				return file_size > 256 * 1024
			end,
		},

		indent = { enable = true },
	})
end

return M
