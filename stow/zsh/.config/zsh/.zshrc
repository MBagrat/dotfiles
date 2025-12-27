# =============================================================================
# Powerlevel10k Instant Prompt
# =============================================================================
# This section enables Powerlevel10k's instant prompt feature, which provides
# a faster shell startup by pre-rendering the prompt.
# Any initialization code that requires console input (password prompts, [y/n]
# confirmations, etc.) must be placed above this block.
# =============================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# Tool Initialization
# =============================================================================
# Initialize various tools and their completions.
# =============================================================================
# Load zsh profiler module
zmodload zsh/zprof

# =============================================================================
# Core Configuration Loading
# =============================================================================
# Load essential configuration files in the correct order to ensure proper
# initialization of the shell environment.
# =============================================================================
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/scripts/directories.zsh"
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/scripts/functions.zsh"
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/scripts/performance.zsh"

# Compile zsh files for improved performance
zsh_compile

# =============================================================================
# Plugin Management (Zap)
# =============================================================================
# Initialize Zap plugin manager and load plugins in the following order:
# 1. Core scripts
# 2. Custom plugins
# 3. External plugins
# 4. Theme
# 5. Aliases
# =============================================================================
[[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ]] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Core scripts
plug "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/scripts/options.zsh"
plug "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/scripts/history.zsh"
plug "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/scripts/completion.zsh"
plug "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/scripts/exports.zsh"
plug "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/scripts/keymaps.zsh"

# Custom plugins
plug "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/supercharge.zsh"

# External plugins
plug "romkatv/powerlevel10k"
plug "hlissner/zsh-autopair"
plug "zap-zsh/fzf"
plug "zap-zsh/exa"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-completions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
plug "MichaelAquilina/zsh-you-should-use"

# Theme
plug "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/themes/p10k.zsh"

# Aliases
plug "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases/aliases.zsh"
plug "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases/omz/git/git.zsh"

# =============================================================================
# Performance Profiling
# =============================================================================
# Enable detailed startup timing information by setting ZSH_PROFILE=1
# Usage: ZSH_PROFILE=1 zsh
# This is useful for debugging slow shell startup times and optimizing
# the configuration.
# =============================================================================
if [[ -n "$ZSH_PROFILE" ]]; then
    zprof
fi
