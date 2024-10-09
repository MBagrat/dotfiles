local M = {
  "hrsh7th/cmp-cmdline",
}

function M.config()
  local cmp = require "cmp"
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      {name = "buffer"},
    }
  })
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      {name = "path"},
    },
    {
      {
        name = "cmdline",
        option = {
          ignore_cmds = {"Man", "!"},
        }
      }
    })
  })
end

return M
