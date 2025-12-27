#!/bin/zsh

# =============================================================================
# Homebrew Shell Environment
# =============================================================================
# This function initializes the Homebrew shell environment by:
# 1. Checking for Homebrew installation in common locations
# 2. Evaluating the appropriate shell environment
# 3. Installing Homebrew if not found
# =============================================================================
function eval_brew() {
  if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  elif [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  else
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

# =============================================================================
# Zsh File Compilation
# =============================================================================
# This function compiles Zsh configuration files for improved performance:
# 1. Checks if compilation is needed by comparing file timestamps
# 2. Creates a cache directory for compiled files
# 3. Compiles all .zsh files with proper permissions
# 4. Maintains directory structure in the cache
# =============================================================================
zsh_compile() {
    local compiled_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compiled"
    local needs_compile=false
    local file compiled_file

    # Check if compilation is needed
    for file in ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/**/*.zsh; do
        compiled_file="$compiled_dir/$(dirname "${file#$XDG_CONFIG_HOME/zsh/}")/$(basename "$file").zwc"
        if [[ ! -f "$compiled_file" || "$file" -nt "$compiled_file" ]]; then
            needs_compile=true
            break
        fi
    done

    if [[ "$needs_compile" = true ]]; then
        # Remove old compiled files
        rm -rf "$compiled_dir"
        mkdir -p "$compiled_dir"

        for file in ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/**/*.zsh; do
            local compiled_dir="$compiled_dir/$(dirname "${file#$XDG_CONFIG_HOME/zsh/}")"
            [[ -d "$compiled_dir" ]] || mkdir -p "$compiled_dir"
            
            # Compile with proper permissions
            zcompile -U "$compiled_dir/$(basename "$file").zwc" "$file"
        done
    fi
}

# =============================================================================
# Compiled File Loading
# =============================================================================
# This function loads compiled Zsh files when available:
# 1. Checks for compiled versions of configuration files
# 2. Sources compiled files if they exist
# 3. Falls back to original files if compiled versions are not available
# =============================================================================
load_compiled() {
    local compiled_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compiled"
    local file compiled_file

    for file in ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/**/*.zsh; do
        compiled_file="$compiled_dir/$(dirname "${file#$XDG_CONFIG_HOME/zsh/}")/$(basename "$file").zwc"
        if [[ -f "$compiled_file" ]]; then
            source "$compiled_file"
        else
            source "$file"
        fi
    done
}

# Run this once to compile all files
# zsh_compile
