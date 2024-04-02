#!/bin/sh

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH

# Load dotfiles binaries
export PATH="$DOTFILES/bin:$PATH"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh

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
