local M = {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
}

function M.config()
    local wk = require "which-key"
    wk.add({
        {"<leader>m", group="Markdown"},
        {"<leader>mo", "<CMD>MarkdownPreview<CR>", desc = "Open Markdown Preview"},
        {"<leader>mc", "<CMD>MarkdownPreviewStop<CR>", desc = "Close Markdown Preview"},
        {"<leader>mt", "<CMD>MarkdownPreviewToggle<CR>", desc = "Toggle Markdown Preview"}
    })
end

return M
