-- Short description: JSON Language Server settings for neovim.
return {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
  },
}
