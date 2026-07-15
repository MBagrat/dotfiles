-- Generic Java/JVM tooling. Spring Boot integration lives in spring.lua,
-- Kotlin tooling in kotlin.lua. jdtls itself (with lombok agent, debug and
-- test adapters) comes from the LazyVim lang.java extra.
return {
  {
    "mfussenegger/nvim-jdtls",
    optional = true,
    opts = function(_, opts)
      -- bigger heap + low-pause GC: multimodule Gradle imports thrash the
      -- default heap
      vim.list_extend(opts.cmd, { "--jvm-arg=-Xmx2g", "--jvm-arg=-XX:+UseZGC" })

      -- main-class scan on attach is a performance killer on multimodule
      -- projects; launching goes through <leader>jr / <leader>jd + attach
      opts.dap_main = false

      local function corretto(v)
        return "/Library/Java/JavaVirtualMachines/amazon-corretto-" .. v .. ".jdk/Contents/Home"
      end
      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          -- jdtls runs on the newest JDK; projects targeting an older
          -- sourceCompatibility resolve against the matching runtime here
          configuration = {
            runtimes = {
              { name = "JavaSE-1.8", path = corretto(8) },
              { name = "JavaSE-11", path = corretto(11) },
              { name = "JavaSE-17", path = corretto(17) },
              { name = "JavaSE-21", path = corretto(21) },
              { name = "JavaSE-25", path = corretto(25), default = true },
            },
          },
          -- go-to-definition into dependencies lands in real sources with
          -- javadoc; fernflower decompiles the rest
          maven = { downloadSources = true },
          eclipse = { downloadSources = true },
          contentProvider = { preferred = "fernflower" },
          compile = { nullAnalysis = { mode = "automatic" } },
          completion = {
            favoriteStaticMembers = {
              "org.assertj.core.api.Assertions.*",
              "org.assertj.core.api.BDDAssertions.*",
              "org.junit.jupiter.api.Assertions.*",
              "org.mockito.Mockito.*",
              "org.mockito.ArgumentMatchers.*",
              "org.mockito.BDDMockito.*",
              "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
              "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
              "org.springframework.test.web.servlet.result.MockMvcResultHandlers.*",
            },
            importOrder = { "java", "javax", "jakarta", "org", "com", "" },
          },
          codeGeneration = {
            toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
            hashCodeEquals = { useJava7Objects = true },
            useBlocks = true,
          },
        },
      })
      return opts
    end,
  },

  -- Spring's canonical Java style (spring-io/spring-javaformat) instead of
  -- jdtls's Eclipse-default formatting. The command is a stow-managed
  -- ~/.local/bin script that self-bootstraps the formatter jar; cwd is the
  -- file's dir so a project .springjavaformatconfig is honored
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = { java = { "spring_javaformat" } },
      formatters = {
        spring_javaformat = {
          command = "spring-javaformat",
          stdin = true,
          cwd = function(_, ctx)
            return vim.fs.dirname(ctx.filename)
          end,
        },
      },
    },
  },

  -- Spring checkstyle conventions (the half spring-javaformat's formatter
  -- can't fix: unused imports, javadoc, naming). spring-checkstyle is the
  -- stow-managed sibling of the spring-javaformat script; a project
  -- checkstyle.xml (Gradle or Spring Boot layout) wins over the bundled
  -- Spring config, which is resolved from the classpath
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = { java = { "checkstyle" } },
      linters = {
        checkstyle = {
          cmd = "spring-checkstyle",
          -- plain output instead of sarif: checkstyle 9.3 (pinned by
          -- spring-javaformat) emits sarif URIs without a file:// scheme,
          -- which nvim-lint's sarif parser rejects
          args = {
            "-f",
            "plain",
            "-c",
            function()
              local root = vim.fs.root(0, { "gradlew", "mvnw", "settings.gradle.kts", "settings.gradle", "pom.xml", ".git" })
              for _, rel in ipairs({ "/config/checkstyle/checkstyle.xml", "/src/checkstyle/checkstyle.xml" }) do
                if root and vim.uv.fs_stat(root .. rel) then
                  return root .. rel
                end
              end
              return "io/spring/javaformat/checkstyle/checkstyle.xml"
            end,
          },
          -- [SEVERITY] /path/File.java:LINE[:COL]: message [RuleName]
          parser = function(output, _)
            local diags = {}
            for line in output:gmatch("[^\r\n]+") do
              local sev, lnum, rest = line:match("^%[(%a+)%] .-:(%d+):(.*)$")
              if sev and rest then
                local col, msg = rest:match("^(%d+):%s*(.+)$")
                msg = msg or rest:match("^%s*(.+)$")
                if msg then
                  local code = msg:match("%[([%w%.]+)%]%s*$")
                  msg = msg:gsub("%s*%[[%w%.]+%]%s*$", "")
                  table.insert(diags, {
                    lnum = tonumber(lnum) - 1,
                    col = col and tonumber(col) - 1 or 0,
                    message = msg,
                    code = code,
                    severity = sev == "WARN" and vim.diagnostic.severity.WARN
                      or sev == "INFO" and vim.diagnostic.severity.INFO
                      or vim.diagnostic.severity.ERROR,
                    source = "spring-checkstyle",
                  })
                end
              end
            end
            return diags
          end,
        },
      },
    },
  },

  -- Gradle build files and Maven pom.xml
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gradle_ls = {},
        lemminx = {},
      },
    },
  },

  -- *.properties highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "properties" } },
  },

  -- Run Java tests through the neotest UI (test.core extra) instead of the
  -- raw jdtls DAP runner: Maven/Gradle multimodule aware, loads
  -- application-test.yml, manages its own JUnit console jar
  {
    "rcasia/neotest-java",
    ft = "java",
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "rcasia/neotest-java" },
    opts = {
      adapters = {
        ["neotest-java"] = {},
      },
    },
  },
}
