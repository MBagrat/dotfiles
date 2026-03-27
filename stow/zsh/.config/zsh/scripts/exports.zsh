#!/bin/zsh

# =============================================================================
# XDG Base Directories
# =============================================================================
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# =============================================================================
# Locale & Editor
# =============================================================================
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export MANPAGER="less"

# =============================================================================
# Shell: Autosuggestions
# =============================================================================
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=true
export ZSH_AUTOSUGGEST_MANUAL_REBIND=true

# =============================================================================
# Homebrew
# =============================================================================
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# =============================================================================
# Development Tools
# =============================================================================

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Node / NVM
export NVM_DIR="$HOME/.nvm"
export PATH="$HOME/.npm-global/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Python (pyenv)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"

# Flutter & Android
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$HOMEBREW_PREFIX/share/flutter/bin:$PATH"
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin"

# Databases (libpq)
export PATH="$HOMEBREW_PREFIX/opt/libpq/bin:$PATH"

# LM Studio
export PATH="$PATH:$HOME/.lmstudio/bin"

# JetBrains Toolbox
export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"

# User bins — prepended last so they take priority
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# =============================================================================
# Tool Configuration
# =============================================================================

# Dotfiles
export DOTFILES="$HOME/.dotfiles"

# fzf
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d . $HOME"
export FZF_TMUX=1
export FZF_TMUX_OPTS="-p 80%"

# eza
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"

# bat
export BAT_THEME="tokyonight_night"

# Starship
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

# Tmuxifier — hardcoded prefix to avoid spawning brew on every shell start
export TMUXIFIER="/usr/local/opt/tpm/share/tpm/plugins/tmuxifier"
export TMUXIFIER_LAYOUT_PATH="$HOME/.config/tmuxifier/layouts"
export PATH="${TMUXIFIER}/bin:$PATH"

# =============================================================================
# Tool Initializers
# =============================================================================
eval "$(fzf --zsh)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(tmuxifier init -)"
eval "$(anyenv init - zsh)"
eval "$(jenv init -)"
eval "$(thefuck --alias)"
eval "$(starship init zsh)"

# 1Password CLI plugins
[[ -f "$HOME/.config/op/plugins.sh" ]] && source "$HOME/.config/op/plugins.sh"
