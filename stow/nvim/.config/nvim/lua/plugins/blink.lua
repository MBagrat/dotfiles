return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        providers = {
          snippets = {
            opts = {
              filter_snippets = function(ft, file)
                if ft == "java" and file:match("friendly%-snippets") then
                  return false
                end
                return true
              end,
            },
          },
        },
      },
    },
  },
}
