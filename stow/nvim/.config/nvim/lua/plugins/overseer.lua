-- Background task runner with output panels (Gradle builds, bootRun, ad-hoc
-- shell tasks); lives in the spring/jvm group next to the spring.lua keymaps
return {
  "stevearc/overseer.nvim",
  cmd = {
    "OverseerOpen",
    "OverseerClose",
    "OverseerToggle",
    "OverseerRun",
    "OverseerRunCmd",
    "OverseerInfo",
    "OverseerBuild",
    "OverseerQuickAction",
    "OverseerTaskAction",
    "OverseerClearCache",
  },
  keys = {
    { "<leader>jo", "<cmd>OverseerToggle<cr>", desc = "Overseer task list" },
    { "<leader>jR", "<cmd>OverseerRun<cr>", desc = "Overseer run task" },
  },
  opts = {},
}
