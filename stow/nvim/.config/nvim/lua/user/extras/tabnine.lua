-- Short description: Tabnine is an AI code completion tool that uses machine learning to predict the most likely code completions.
-- Github repository: tzachar/cmp-tabnine
local M = {
    "tzachar/cmp-tabnine",
    event = "InsertEnter",
    build = "./install.sh",
}

function M.config() end

return M
