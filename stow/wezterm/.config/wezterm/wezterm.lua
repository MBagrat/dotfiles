-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 15

config.adjust_window_size_when_changing_font_size = false
config.color_scheme = "Tokyo Night"
-- config.color_scheme = "tokyonight"

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

-- config.window_background_opacity = 0.9
config.macos_window_background_blur = 10

return config
