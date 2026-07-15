-- Kotlin tooling on top of the LazyVim lang.kotlin extra (treesitter,
-- ktlint, DAP configurations). Spring Boot integration lives in spring.lua.
return {
  -- JetBrains' official Kotlin LSP (IntelliJ-based, understands Gradle/Maven
  -- project models incl. build.gradle.kts): replaces the community
  -- kotlin_language_server the extra configures, which crashes on
  -- startup with JDK 25 (IllegalArgumentException: 25.0.3)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_language_server = { enabled = false },
        kotlin_lsp = {},
      },
    },
  },

  -- The kotlin extra wires dap.adapters.kotlin to the kotlin-debug-adapter
  -- binary but only ensures ktlint is installed
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "kotlin-debug-adapter", "detekt" } },
  },

  -- Kotest specs into the neotest UI. Kotlin JUnit tests run via the
  -- <leader>jT / <leader>jn Gradle filters in spring.lua instead — no
  -- reliable JUnit adapter exists for Kotlin yet
  { "codymikol/neotest-kotlin" },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "codymikol/neotest-kotlin" },
    opts = {
      adapters = {
        ["neotest-kotlin"] = {},
      },
    },
  },

  -- Surface detekt findings inline (next to ktlint) in projects that carry a
  -- detekt.yml; nvim-lint appends the buffer path after --input
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = { kotlin = { "ktlint", "detekt" } },
      linters = {
        detekt = {
          condition = function(ctx)
            return vim.fs.find({ "detekt.yml" }, { path = ctx.filename, upward = true })[1] ~= nil
          end,
          args = {
            "--build-upon-default-config",
            "--config",
            function()
              return vim.fs.find({ "detekt.yml" }, { path = vim.api.nvim_buf_get_name(0), upward = true })[1]
            end,
            "--input",
          },
        },
      },
    },
  },
}
