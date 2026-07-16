-- Kubernetes dashboard inside nvim. version = "2.*" pulls the prebuilt
-- rust backend via blink.download (no cargo needed); requires kubectl on
-- PATH
return {
  "ramilito/kubectl.nvim",
  version = "2.*",
  dependencies = { "saghen/blink.download" },
  keys = {
    {
      "<leader>k",
      function()
        require("kubectl").toggle({ tab = true })
      end,
      desc = "kubectl",
    },
  },
  config = function()
    require("kubectl").setup()
  end,
}
