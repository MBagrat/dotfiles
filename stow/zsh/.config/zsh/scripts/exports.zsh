#!/bin/sh

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH

[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history/" ] || mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history/"
[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump/" ] || mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump/"

# Completion configuration
autoload -Uz compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump/.zcompdump-${HOST}-${ZSH_VERSION}"
compinit -C -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump/.zcompdump-${HOST}-${ZSH_VERSION}"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# History file configuration
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

# History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history Data

DOTFILES=$HOME/.dotfiles

# Load dotfiles binaries
export PATH="$PATH:$DOTFILES/bin"

# Jetbrains Toolbox script paths
export PATH=$PATH:$HOME/Library/Application\ Support/JetBrains/Toolbox/scripts/

# Generate the kubectl completion script for Zsh on this path ($HOME/.oh-my-zsh/cache/completions/_kubectl)
# https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/#install-with-homebrew-on-macos
# shellcheck source=/usr/local/bin/kubectl
source <(kubectl completion zsh)

# Generate the buildpack completion script for Zsh on this path ($HOME/.pack/completion.zsh)
# shellcheck source=/Users/mbagrat/.pack/completion.zsh
source "$(pack completion -s zsh)"

# All in one for **env
# https://anyenv.github.io/
eval "$(anyenv init - zsh)"

# Postgres Client API library
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# 1password zsh completion
# https://developer.1password.com/docs/cli/get-started#shell-completion
eval "$(op completion zsh)"; compdef _op op

# Make sure coreutils are loaded before system commands
# I've disabled this for now because I only use "ls" which is
# referenced in my aliases.zsh file directly.
#export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# Project ENV variables
export npm_config_azure_user_name=op://AmeriaBank/Azure_Devops/username
export npm_config_azure_access_token=op://AmeriaBank/Azure_Devops/access_token_base64
export npm_config_azure_user_email=op://AmeriaBank/Azure_Devops/username
