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

      -- Unlock decompiled class navigation and the advanced refactorings
      -- (extract interface, move member, hashCode/equals generation prompts).
      opts.jdtls = {
        init_options = {
          extendedClientCapabilities = vim.tbl_deep_extend(
            "force",
            require("jdtls").extendedClientCapabilities,
            { resolveAdditionalTextEditsSupport = true }
          ),
        },
      }

      local function corretto(v)
        return "/Library/Java/JavaVirtualMachines/amazon-corretto-" .. v .. ".jdk/Contents/Home"
      end
      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          configuration = {
            updateBuildConfiguration = "interactive",
            -- jdtls runs on the newest JDK; projects targeting an older
            -- sourceCompatibility resolve against the matching runtime here
            runtimes = {
              { name = "JavaSE-1.8", path = corretto(8) },
              { name = "JavaSE-11", path = corretto(11) },
              { name = "JavaSE-17", path = corretto(17) },
              { name = "JavaSE-21", path = corretto(21) },
              { name = "JavaSE-25", path = corretto(25), default = true },
            },
          },
          -- Google's Eclipse formatter profile, vendored in the java stow
          -- package (single source of truth — import the same file into
          -- IntelliJ via Code Style > Import Scheme > Eclipse XML Profile)
          format = {
            enabled = true,
            settings = {
              url = vim.fn.expand(vim.fn.expand("~") .. "/.config/java/eclipse-java-intellij-style.xml"),
              profile = "IntelliJStyle",
            },
            comments = {
              enabled = true,
            },
          },
          -- go-to-definition into dependencies lands in real sources with
          -- javadoc; fernflower decompiles the rest
          eclipse = { downloadSources = true },
          maven = { downloadSources = true },
          import = {
            gradle = { enabled = true, wrapper = { enabled = true } },
            maven = { enabled = true },
          },
          references = { includeDecompiledSources = true },
          contentProvider = { preferred = "fernflower" },

          -- IntelliJ-style gutter lenses: run counts of refs/implementations.
          referencesCodeLens = { enabled = true },
          implementationsCodeLens = { enabled = true },
          signatureHelp = { enabled = true, description = { enabled = true } },

          compile = { nullAnalysis = { mode = "automatic" } },
          completion = {
            favoriteStaticMembers = {
              "org.assertj.core.api.Assertions.*",
              "org.assertj.core.api.BDDAssertions.*",
              "org.junit.jupiter.api.Assertions.*",
              "org.junit.jupiter.api.Assumptions.*",
              "org.junit.jupiter.api.DynamicTest.*",
              "org.mockito.Mockito.*",
              "org.mockito.ArgumentMatchers.*",
              "org.mockito.BDDMockito.*",
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
              "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
              "org.springframework.test.web.servlet.result.MockMvcResultHandlers.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
            },
            filteredTypes = {
              "com.sun.*",
              "io.micrometer.shaded.*",
              "java.awt.*",
              "jdk.*",
              "sun.*",
            },
            -- IntelliJ IDEA default layout: everything else, javax, java,
            -- statics last ("" = all other imports, "#" = static imports)
            importOrder = { "javax", "java", "", "#" },
          },
          -- Never collapse imports into wildcards.
          sources = {
            organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
          },

          codeGeneration = {
            toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
            hashCodeEquals = { useJava7Objects = true },
            useBlocks = true,
          },

          inlayHints = { parameterNames = { enabled = "all" } },
        },
      })
      return opts
    end,
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

  -- build.gradle (groovy) and *.properties highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "groovy", "properties" } },
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
