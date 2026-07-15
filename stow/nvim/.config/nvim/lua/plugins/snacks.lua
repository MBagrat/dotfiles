return {
  "folke/snacks.nvim",
  opts = {
    -- Inline image rendering via the kitty graphics protocol (works through
    -- tmux thanks to `allow-passthrough on` in tmux.conf)
    image = {
      resolve = function(path, src)
        -- Resolve Obsidian attachments (e.g. ![[foo.png]]) against the vault
        if require("obsidian.api").path_is_note(path) then
          return require("obsidian.api").resolve_image_path(src)
        end
      end,
    },
  },
}
