return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
    config = function()
      -- Helper function to find Flutter SDK path
      local function find_flutter_sdk()
        -- Try multiple common locations
        local possible_paths = {
          vim.fn.expand("$HOMEBREW_PREFIX") .. "/share/flutter",
          vim.fn.expand("$HOME") .. "/flutter",
          vim.fn.expand("$HOME") .. "/development/flutter",
        }

        -- Check if flutter command exists and get its path
        local flutter_cmd = vim.fn.exepath("flutter")
        if flutter_cmd ~= "" then
          local flutter_dir = vim.fn.fnamemodify(flutter_cmd, ":h:h")
          table.insert(possible_paths, 1, flutter_dir)
        end

        for _, path in ipairs(possible_paths) do
          if vim.fn.isdirectory(path) == 1 then
            return path
          end
        end

        -- Fallback to homebrew location
        return vim.fn.expand("$HOMEBREW_PREFIX") .. "/share/flutter"
      end

      local flutter_sdk_path = find_flutter_sdk()
      local dart_sdk_path = flutter_sdk_path .. "/bin/cache/dart-sdk"

      -- Validate paths exist
      if vim.fn.isdirectory(flutter_sdk_path) ~= 1 then
        vim.notify("Flutter SDK not found at: " .. flutter_sdk_path, vim.log.levels.WARN)
      end

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
            local dap = require("dap")
            if not dap then
              return
            end

            -- Flutter debug adapter
            dap.adapters.flutter = {
              type = "executable",
              command = "flutter",
              args = { "debug-adapter" },
              options = {
                detached = false,
              },
            }

            -- Dart debug adapter (for pure Dart projects)
            dap.adapters.dart = {
              type = "executable",
              command = "dart",
              args = { "debug_adapter" },
              options = {
                detached = false,
              },
            }

            -- Flutter launch configurations
            dap.configurations.dart = dap.configurations.dart or {}
            dap.configurations.flutter = dap.configurations.flutter or {}

            -- Debug mode
            table.insert(dap.configurations.flutter, {
              type = "flutter",
              request = "launch",
              name = "Flutter: Debug",
              dartSdkPath = dart_sdk_path,
              flutterSdkPath = flutter_sdk_path,
              program = "${workspaceFolder}/lib/main.dart",
              cwd = "${workspaceFolder}",
              toolArgs = { "--flavor", "dev" }, -- Optional: for flavor support
            })

            -- Profile mode
            table.insert(dap.configurations.flutter, {
              type = "flutter",
              request = "launch",
              name = "Flutter: Profile",
              dartSdkPath = dart_sdk_path,
              flutterSdkPath = flutter_sdk_path,
              program = "${workspaceFolder}/lib/main.dart",
              cwd = "${workspaceFolder}",
              flutterMode = "profile",
            })

            -- Release mode (limited debugging)
            table.insert(dap.configurations.flutter, {
              type = "flutter",
              request = "launch",
              name = "Flutter: Release",
              dartSdkPath = dart_sdk_path,
              flutterSdkPath = flutter_sdk_path,
              program = "${workspaceFolder}/lib/main.dart",
              cwd = "${workspaceFolder}",
              flutterMode = "release",
            })

            -- Attach to existing Flutter process
            table.insert(dap.configurations.flutter, {
              type = "flutter",
              request = "attach",
              name = "Flutter: Attach",
              dartSdkPath = dart_sdk_path,
              flutterSdkPath = flutter_sdk_path,
            })
          end,
        },
        -- flutter_path = "<full/path/if/needed>", -- <-- this takes priority over the lookup
        -- flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
        root_patterns = { ".git", "pubspec.yaml", ".fvm" }, -- patterns to find the root of your flutter project
        fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
        -- Optional: if using FVM, set to true
        -- fvm = true,
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
          -- Optional: filter out verbose logs
          -- filter = function(log_line)
          --   return not string.match(log_line, "DEBUG")
          -- end,
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
          on_attach = require("snacks.util").lsp.on,
          capabilities = (function()
            local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
            if ok then
              return cmp_lsp.default_capabilities()
            end
            -- Fallback to LazyVim capabilities if cmp_nvim_lsp not available
            local ok2, lazyvim = pcall(require, "lazyvim.util")
            if ok2 and lazyvim.lsp then
              return lazyvim.lsp.capabilities()
            end
            return {}
          end)(),
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            enableSdkFormatter = true,
            analysisExcludedFolders = {
              flutter_sdk_path .. "/packages",
              flutter_sdk_path .. "/bin/cache",
            },
            -- Additional useful settings
            enableServerSnippets = true,
            onlyAnalyzeProjectsWithOpenFiles = false,
            suggestFromUnimportedLibraries = true,
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
            -- Additional analysis options
            closingLabels = true,
            completeFunctionCalls = true,
            enableCompletionCommitCharacters = true,
            enableFolding = true,
            enableOnlyEnableAnalyzer = false,
            enableServerSnippets = true,
            hints = {
              enable = true,
              parameterNames = true,
              parameterTypes = true,
              variableNames = false,
              returnTypes = true,
            },
          },
        },
      })
    end,
  },
}
