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
