-- JaCoCo coverage signs next to neotest results. Run the Gradle
-- jacocoTestReport task first; the path below is Gradle's default output
-- (per module — run :Coverage from the module directory or set an
-- override in a project-local config)
return {
  "andythigpen/nvim-coverage",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "Coverage", "CoverageLoad", "CoverageShow", "CoverageHide", "CoverageToggle", "CoverageSummary" },
  keys = {
    { "<leader>tc", "<cmd>Coverage<cr>", desc = "Coverage (load & show)" },
    { "<leader>tC", "<cmd>CoverageSummary<cr>", desc = "Coverage summary" },
  },
  config = function()
    require("coverage").setup({
      auto_reload = true,
      lang = {
        java = {
          coverage_file = "build/reports/jacoco/test/jacocoTestReport.xml",
        },
      },
    })
  end,
}
