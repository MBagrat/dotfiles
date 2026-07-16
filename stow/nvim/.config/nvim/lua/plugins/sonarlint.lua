-- SonarLint diagnostics for Java (+ pom/config XML). The language server and
-- analyzer jars come from the mason sonarlint-language-server package; recent
-- versions no longer bundle sonarkotlin.jar, so Kotlin is not wired up here
return {
  {
    "mason.nvim",
    opts = { ensure_installed = { "sonarlint-language-server" } },
  },
  {
    "sonarlint.nvim",
    url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    ft = { "java", "xml" },
    dependencies = { "mason.nvim" },
    config = function()
      require("sonarlint").setup({
        server = {
          cmd = {
            vim.fn.expand("$MASON/bin/sonarlint-language-server"),
            "-stdio",
            "-analyzers",
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjavasymbolicexecution.jar"),
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarxml.jar"),
          },
        },
        filetypes = { "java", "xml" },
      })
    end,
  },
}
