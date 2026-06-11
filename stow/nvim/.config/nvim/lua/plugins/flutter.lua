return {
  {
    "akinsho/flutter-tools.nvim",
    ft = { "dart" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local function find_flutter_sdk()
        local candidates = {}

        local flutter_cmd = vim.fn.exepath("flutter")
        if flutter_cmd ~= "" then
          local resolved = vim.fn.resolve(flutter_cmd)
          table.insert(candidates, vim.fn.fnamemodify(resolved, ":h:h"))
        end

        vim.list_extend(candidates, {
          vim.fn.expand("$HOMEBREW_PREFIX") .. "/share/flutter",
          vim.fn.expand("$HOME") .. "/flutter",
          vim.fn.expand("$HOME") .. "/development/flutter",
        })

        for _, path in ipairs(candidates) do
          if vim.fn.isdirectory(path .. "/bin/cache/dart-sdk") == 1 then
            return path
          end
        end
        return nil
      end

      local flutter_sdk_path = find_flutter_sdk()

      local analysis_excluded_folders = nil
      if flutter_sdk_path then
        analysis_excluded_folders = {
          flutter_sdk_path .. "/packages",
          flutter_sdk_path .. "/.pub-cache",
          flutter_sdk_path .. "/bin/cache",
        }
      end

      require("flutter-tools").setup({
        ui = {
          border = "rounded",
          notification_style = "native",
        },
        decorations = {
          statusline = {
            app_version = true,
            device = true,
            project_config = true,
          },
        },
        debugger = {
          enabled = true,
          register_configurations = function(paths)
            local ok, dap = pcall(require, "dap")
            if not ok then return end

            for _, mode in ipairs({ "profile", "release" }) do
              table.insert(dap.configurations.dart, {
                type = "dart",
                request = "launch",
                name = "Flutter: " .. mode:gsub("^%l", string.upper),
                dartSdkPath = paths.dart_sdk,
                flutterSdkPath = paths.flutter_sdk,
                program = "lib/main.dart",
                cwd = "${workspaceFolder}",
                flutterMode = mode,
              })
            end
          end,
        },
        root_patterns = { ".git", "pubspec.yaml", ".fvm" },
        widget_guides = { enabled = true },
        closing_tags = { highlight = "ErrorMsg" },
        lsp = {
          capabilities = (function()
            local ok, blink_cmp = pcall(require, "blink.cmp")
            if ok then return blink_cmp.get_lsp_capabilities() end
            return {}
          end)(),
          init_options = {
            onlyAnalyzeProjectsWithOpenFiles = false,
          },
          settings = {
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            lineLength = 100,
            analysisExcludedFolders = analysis_excluded_folders,
          },
        },
      })
    end,
  },
}
