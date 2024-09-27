-- Short description: Launches the plugins specified in the spec files
-- Github repository: ThePrimeagen/lazy.nvim
LAZY_PLUGIN_SPEC = {}

function spec(item)
  table.insert(LAZY_PLUGIN_SPEC, { import = item })
end
