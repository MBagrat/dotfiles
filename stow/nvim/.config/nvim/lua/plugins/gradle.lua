-- Gradle task/dependency explorer; complements the raw bootRun/test keymaps
-- in spring.lua for browsing multimodule projects
return {
  "oclay1st/gradle.nvim",
  cmd = { "Gradle", "GradleExec", "GradleInit", "GradleFavorites" },
  dependencies = { "MunifTanjim/nui.nvim" },
  keys = {
    { "<leader>jg", "<cmd>Gradle<cr>", desc = "Gradle projects" },
    { "<leader>jG", "<cmd>GradleExec<cr>", desc = "Gradle exec command" },
  },
  opts = {},
}
