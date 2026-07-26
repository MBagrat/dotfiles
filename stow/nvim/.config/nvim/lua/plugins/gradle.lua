-- Gradle task/dependency explorer; complements the raw bootRun/test keymaps
-- in spring.lua for browsing multimodule projects
return {
  "oclay1st/gradle.nvim",
  cmd = { "Gradle", "GradleExec", "GradleInit", "GradleFavorites" },
  dependencies = { "MunifTanjim/nui.nvim" },
  keys = {
    { "<leader>jg", "<cmd>Gradle<cr>", desc = "Gradle projects" },
    { "<leader>jG", "<cmd>GradleExec<cr>", desc = "Gradle exec command" },
    { "<leader>ji", "<cmd>GradleInit<cr>", desc = "Gradle init project" },
    { "<leader>jf", "<cmd>GradleFavorites<cr>", desc = "Gradle favorite commands" },
  },
  opts = function()
    -- default gradle_executable is the bare "gradle" on PATH, which can be a
    -- different version than the project's wrapper (see spring.lua's same check)
    local root = vim.fs.root(0, { "gradlew", "settings.gradle.kts", "settings.gradle" }) or vim.uv.cwd()
    local wrapper = root .. "/gradlew"
    local executable = vim.uv.fs_stat(wrapper) and wrapper or "gradle"
    return {
      gradle_executable = executable,
      projects_view = {
        custom_commands = {
          { name = "clean", cmd_args = { "clean" }, description = "Clean build outputs" },
          { name = "build", cmd_args = { "build" }, description = "Build the project" },
          { name = "test", cmd_args = { "test" }, description = "Run tests" },
          { name = "bootRun", cmd_args = { "bootRun" }, description = "Run the Spring Boot application" },
        },
      },
    }
  end,
}
