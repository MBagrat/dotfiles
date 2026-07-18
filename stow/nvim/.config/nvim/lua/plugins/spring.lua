-- Spring Boot integration on top of the LazyVim java extra (java.lua) and
-- kotlin.lua: the official Spring Boot language server plus its jdtls
-- extensions. Property/yaml completion, bean & request-mapping navigation,
-- Spring-specific diagnostics. Also <leader>j run/build keymaps below.

-- Run Gradle/Maven tasks in a tmux split (Snacks terminal outside tmux).
-- <leader>jd suspends the JVM on :5005 — pair it with the "Debug (Attach) -
-- Remote" DAP configuration the java/kotlin extras already define.
local function run_task(gradle_task, maven_args)
  local root = vim.fs.root(0, { "gradlew", "mvnw", "settings.gradle.kts", "settings.gradle", "pom.xml" })
  if not root then
    return vim.notify("No Gradle/Maven project root found", vim.log.levels.WARN)
  end
  local cmd
  if vim.uv.fs_stat(root .. "/gradlew") then
    cmd = "./gradlew " .. gradle_task
  elseif vim.uv.fs_stat(root .. "/mvnw") then
    cmd = "./mvnw " .. maven_args
  elseif vim.uv.fs_stat(root .. "/pom.xml") then
    cmd = "mvn " .. maven_args
  else
    cmd = "gradle " .. gradle_task
  end
  if vim.env.TMUX then
    vim.fn.system({
      "tmux",
      "split-window",
      "-v",
      "-l",
      "30%",
      "-c",
      root,
      cmd .. [[; printf '\n[exit %s] press enter to close' "$?"; read -r _]],
    })
  else
    Snacks.terminal(cmd, { cwd = root })
  end
end

local debug_jvm_maven = "spring-boot:run"
  .. [[ -Dspring-boot.run.jvmArguments='-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5005']]

-- Filtered JUnit runs for Kotlin buffers (Java goes through neotest-java).
-- Returns the fully-qualified class of the current file, plus the enclosing
-- function name when `nearest` is set. Backticked test names keep their
-- spaces; Gradle/Surefire filters accept them quoted.
local function kotlin_test_target(nearest)
  local fqn = vim.fn.expand("%:t:r")
  for _, l in ipairs(vim.api.nvim_buf_get_lines(0, 0, 50, false)) do
    local pkg = l:match("^%s*package%s+([%w_%.]+)")
    if pkg then
      fqn = pkg .. "." .. fqn
      break
    end
  end
  if not nearest then
    return fqn
  end
  local node = vim.treesitter.get_node()
  while node and node:type() ~= "function_declaration" do
    node = node:parent()
  end
  if node then
    for child in node:iter_children() do
      if child:type() == "simple_identifier" then
        return fqn, vim.treesitter.get_node_text(child, 0):gsub("`", "")
      end
    end
  end
  return fqn
end

-- Multimodule projects: a bare `gradlew test --tests X` fails in every module
-- without a match, so scope the task to the module owning the buffer
local function gradle_test_task(root)
  local build_file = vim.fs.find({ "build.gradle.kts", "build.gradle" }, {
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
    upward = true,
    stop = vim.fs.dirname(root),
  })[1]
  local module_dir = build_file and vim.fs.dirname(build_file)
  if not module_dir or module_dir == root then
    return "test"
  end
  return module_dir:sub(#root + 2):gsub("/", ":") .. ":test"
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java", "kotlin" },
  group = vim.api.nvim_create_augroup("spring_boot_run_keys", { clear = true }),
  callback = function(ev)
    local maps = {
      { "<leader>jr", "bootRun", "spring-boot:run", "Boot Run" },
      { "<leader>jd", "bootRun --debug-jvm", debug_jvm_maven, "Boot Run (debug, attach :5005)" },
      { "<leader>jt", "test", "test", "Test" },
      { "<leader>jb", "build", "package", "Build" },
      { "<leader>jc", "clean", "clean", "Clean" },
    }
    for _, m in ipairs(maps) do
      vim.keymap.set("n", m[1], function()
        run_task(m[2], m[3])
      end, { buffer = ev.buf, desc = m[4] })
    end

    if ev.match == "kotlin" then
      local function run_filtered(nearest)
        local root = vim.fs.root(0, { "gradlew", "mvnw", "settings.gradle.kts", "settings.gradle", "pom.xml" })
        if not root then
          return vim.notify("No Gradle/Maven project root found", vim.log.levels.WARN)
        end
        local fqn, fn = kotlin_test_target(nearest)
        local gradle_filter = fn and (fqn .. "." .. fn) or fqn
        local maven_filter = fn and (fqn .. "#" .. fn) or fqn
        run_task(
          string.format('%s --tests "%s"', gradle_test_task(root), gradle_filter),
          string.format('test -Dtest="%s"', maven_filter)
        )
      end
      vim.keymap.set("n", "<leader>jT", function()
        run_filtered(false)
      end, { buffer = ev.buf, desc = "Test Class (JUnit)" })
      vim.keymap.set("n", "<leader>jn", function()
        run_filtered(true)
      end, { buffer = ev.buf, desc = "Test Nearest (JUnit)" })
    end
  end,
})

return {
  -- Spring Boot language server (vscode-spring-boot-tools via Mason).
  -- The plugin's built-in autocmd hardcodes java/yaml/jproperties, so
  -- disable it and register our own with kotlin included. setup() returns
  -- the resolved config (nil when the LS jar isn't installed yet);
  -- lazy.nvim re-fires FileType after ft-lazy loading, so the buffer that
  -- triggered the load still attaches.
  {
    "JavaHello/spring-boot.nvim",
    ft = { "java", "kotlin", "yaml", "jproperties" },
    dependencies = {
      { "mason-org/mason.nvim", opts = { ensure_installed = { "vscode-spring-boot-tools" } } },
    },
    opts = { autocmd = false },
    config = function(_, opts)
      local resolved = require("spring_boot").setup(opts)
      if not resolved or not resolved.ls_path then
        return
      end
      local launch = require("spring_boot.launch")
      local client_config = launch.update_ls_config(resolved)
      -- nvim 0.12 keeps one shared inlay-hint version per buffer across all
      -- clients, so hints from a secondary server can be drawn against a
      -- newer buffer revision and crash extmark placement ("Invalid 'col'").
      -- jdtls/kotlin_lsp stay the only hint providers (fixed on nvim master)
      local on_init = client_config.on_init
      client_config.on_init = function(client, ...)
        if on_init then
          on_init(client, ...)
        end
        client.server_capabilities.inlayHintProvider = nil
      end
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("spring_boot_ls_kotlin", { clear = true }),
        pattern = { "java", "kotlin", "yaml", "jproperties" },
        desc = "Spring Boot Language Server (incl. Kotlin)",
        callback = function()
          launch.start(client_config)
        end,
      })
    end,
  },

  -- Append the Spring Boot jdtls extension jars to the bundles the LazyVim
  -- java extra builds (java-debug-adapter + java-test); opts.jdtls receives
  -- the final config right before start_or_attach
  {
    "mfussenegger/nvim-jdtls",
    optional = true,
    opts = {
      jdtls = function(config)
        local ok, spring_boot = pcall(require, "spring_boot")
        if ok then
          vim.list_extend(config.init_options.bundles, spring_boot.java_extensions())
        end
        return config
      end,
    },
  },
}
