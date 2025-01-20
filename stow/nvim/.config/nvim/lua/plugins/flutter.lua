return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
    config = function()
      -- Define common paths
      local flutter_sdk_path = vim.fn.expand("$HOMEBREW_PREFIX") .. "/share/flutter/"
      local dart_sdk_path = flutter_sdk_path .. "bin/cache/dart-sdk/"
      require("flutter-tools").setup({
        ui = {
          -- the border type to use for all floating windows, the same options/formats
          -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
          border = "rounded",
          -- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
          -- please note that this option is eventually going to be deprecated and users will need to
          -- depend on plugins like `nvim-notify` instead.
          notification_style = "plugin",
        },
        decorations = {
          statusline = {
            -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
            -- this will show the current version of the flutter app from the pubspec.yaml file
            app_version = true,
            -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
            -- this will show the currently running device if an application was started with a specific
            -- device
            device = true,
            -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
            -- this will show the currently selected project configuration
            project_config = true,
          },
        },
        debugger = {
          enabled = true,
          run_via_dap = true,
          register_configurations = function(_)
            require("dap").adapters.dart = {
              type = "executable",
              command = "dart",
              -- args = { "flutter" },
              args = { "debug_adapter" },
              options = {
                detached = false,
              },
            }

            require("dap").adapters.flutter = {
              type = "executable",
              command = "flutter",
              -- args = { "flutter" },
              args = { "debug-adapter" },
              options = {
                detached = false,
              },
            }

            require("dap").configurations.dart = {
              {
                type = "dart",
                request = "launch",
                name = "Launch flutter",
                dartSdkPath = dart_sdk_path,
                flutterSdkPath = flutter_sdk_path,
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
              },
            }

            require("dap").configurations.flutter = {
              {
                type = "flutter",
                request = "launch",
                name = "Launch flutter",
                dartSdkPath = dart_sdk_path,
                flutterSdkPath = flutter_sdk_path,
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
              },
            }

            -- require("dap.ext.vscode").load_launchjs()
          end,
        },
        -- flutter_path = "<full/path/if/needed>", -- <-- this takes priority over the lookup
        -- flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
        root_patterns = { ".git", "pubspec.yaml" }, -- patterns to find the root of your flutter project
        fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
        widget_guides = {
          enabled = true,
        },
        closing_tags = {
          highlight = "ErrorMsg", -- highlight for the closing tag
          prefix = "// ", -- character to use for close tag e.g. > Widget
          priority = 10, -- priority of virtual text in current line
          -- consider to configure this when there is a possibility of multiple virtual text items in one line
          -- see `priority` option in |:help nvim_buf_set_extmark| for more info
          enabled = true, -- set to false to disable
        },
        dev_log = {
          enabled = true,
          filter = nil, -- optional callback to filter the log
          -- takes a log_line as string argument; returns a boolean or nil;
          -- the log_line is only added to the output if the function returns true
          notify_errors = false, -- if there is an error whilst running then notify the user
          open_cmd = "15split", -- command to use to open the log buffer
          focus_on_open = true, -- focus on the newly opened log window
        },
        dev_tools = {
          autostart = false, -- autostart devtools server if not detected
          auto_open_browser = false, -- Automatically opens devtools in the browser
        },
        outline = {
          open_cmd = "30vnew", -- command to use to open the outline buffer
          auto_open = false, -- if true this will open the outline automatically when it is first populated
        },
        lsp = {
          color = { -- show the derived colours for dart variables
            enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
            background = false, -- highlight the background
            background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
            foreground = false, -- highlight the foreground
            virtual_text = true, -- show the highlight using virtual text
            virtual_text_str = "■", -- the virtual text character to highlight
          },
          on_attach = require("lazyvim.util").lsp.on_attach,
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            enableSdkFormatter = true,
            analysisExcludedFolders = {
              flutter_sdk_path .. "/packages",
            },
          },
          lineLength = 100,
          formatOnSave = true,
          updateImportsOnRename = true,
          previewHotReloadOnSave = true,
          -- Analysis settings
          analysis = {
            autoImportCompletions = true,
            diagnosticMode = "workspace",
            enableSdkFormatter = true,
            useInlineHints = true,
            -- Performance optimizations
            maxCompletionItems = 1000,
            maxFilesToAnalyze = 5000,
            enableAsyncCompletion = true,
          },
        },
      })
    end,
  },
}
