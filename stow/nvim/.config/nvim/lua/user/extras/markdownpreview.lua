local M = {
    "iamcco/markdown-preview.nvim",
    cmd = {"MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"},
    ft = {"markdown"},
    build = function()
        vim.fn["mkdp#util#install"]()
    end
}

function M.config()
    local wk = require "which-key"
    wk.register({
        m = {
            name = "+Markdown",
            o = {"<cmd>MarkdownPreview<cr>", "Open Markdown Preview"},
            c = {"<cmd>MarkdownPreviewStop<cr>", "Close Markdown Preview"},
            t = {"<cmd>MarkdownPreviewToggle<cr>", "Toggle Markdown Preview"}
        }
    }, { prefix = "<leader>" })
end

return M
