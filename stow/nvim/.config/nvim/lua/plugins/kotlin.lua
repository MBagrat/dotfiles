-- Kotlin tooling on top of the LazyVim lang.kotlin extra (treesitter,
-- ktlint, DAP configurations). Spring Boot integration lives in spring.lua.

-- <leader>co mirrors the jdtls organize-imports keymap the java extra
-- provides: kotlin-lsp's source.organizeImports expands wildcard imports
-- into exact ones (per .editorconfig ij_kotlin_name_count settings) and
-- drops unused imports. Known kotlin-lsp gap: packages on IntelliJ's
-- built-in star list (java.util.*, kotlinx.android.synthetic.*) are never
-- expanded — ij_kotlin_packages_to_use_star_imports is ignored as of
-- kotlin-lsp 262.8190.0 — those need a manual fix when ktlint flags them.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "kotlin",
  group = vim.api.nvim_create_augroup("kotlin_organize_imports", { clear = true }),
  callback = function(ev)
    vim.keymap.set("n", "<leader>co", function()
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" }, diagnostics = {} },
        apply = true,
      })
    end, { buffer = ev.buf, desc = "Organize Imports" })
  end,
})

return {
  -- JetBrains' official Kotlin LSP (IntelliJ-based, understands Gradle/Maven
  -- project models incl. build.gradle.kts): replaces the community
  -- kotlin_language_server the extra configures, which crashes on
  -- startup with JDK 25 (IllegalArgumentException: 25.0.3)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_lsp = {
          -- The default root_markers stop at the *nearest* pom.xml, which in
          -- a Maven multi-module project is the submodule you happened to
          -- open — kotlin-lsp then imports just that module and references
          -- from sibling modules come back empty. Prefer an explicit
          -- workspace/Gradle root; otherwise climb the contiguous chain of
          -- pom.xml directories to the aggregator pom.
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local root = vim.fs.root(fname, {
              "settings.gradle",
              "settings.gradle.kts",
              "workspace.json",
            })
            if not root then
              for dir in vim.fs.parents(fname) do
                if vim.uv.fs_stat(vim.fs.joinpath(dir, "pom.xml")) then
                  root = dir
                elseif root then
                  break
                end
              end
            end
            on_dir(root or vim.fs.root(fname, { "build.gradle", "build.gradle.kts", ".git" }))
          end,
        },
        kotlin_language_server = { enabled = false },
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

  -- Two ktlint CLI problems break conform's default stdin invocation:
  --  1. ktlint exits 1 whenever violations it cannot auto-correct remain
  --     (wildcard imports, max-line-length...), so conform discarded the
  --     whole format even though the formatted code was fine.
  --  2. In --stdin mode ktlint prints the result via printf, so a literal
  --     %s anywhere in the source crashes it mid-write and only a truncated
  --     prefix reaches stdout (MissingFormatArgumentException, ktlint 1.8.0).
  -- Formatting a temp file in place avoids the printf path entirely — on a
  -- crash the temp file is left untouched and the buffer stays intact — and
  -- exit 1 (violations remain) is accepted as success; the violations still
  -- surface via nvim-lint. The temp file's .conform.* name trips the
  -- standard:filename rule, which is harmless: not auto-correctable, so it
  -- never edits the code, and diagnostics come from nvim-lint on the real
  -- file name.
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ktlint = {
          stdin = false,
          args = { "--format", "--log-level=none", "$FILENAME" },
          exit_codes = { 0, 1 },
        },
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

  -- The extra registers ktlint in both nvim-lint and none-ls, which posts
  -- every diagnostic twice. Drop the none-ls copy; nvim-lint keeps
  -- diagnostics and conform keeps formatting.
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.sources = vim.tbl_filter(function(source)
        return source.name ~= "ktlint"
      end, opts.sources or {})
    end,
  },
}
