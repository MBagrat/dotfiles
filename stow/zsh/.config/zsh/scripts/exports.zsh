#!/bin/sh

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH

# Load zsh profiler module
zmodload zsh/zprof

[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history/" ] || mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history/"
[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump/" ] || mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump/"

# Disable shell sessions
SHELL_SESSIONS_DISABLE=1

# Completion configuration
autoload -Uz compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump/.zcompdump-${HOST}-${ZSH_VERSION}"
compinit -C -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump/.zcompdump-${HOST}-${ZSH_VERSION}"

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

export LC_ALL=en_US.UTF-8;

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

# Load tmuxifier scripts
# https://github.com/jimeh/tmuxifier
export EDITOR="nvim"
export PATH="$PATH:$HOMEBREW_PREFIX/opt/tpm/share/tpm/plugins/tmuxifier/bin"
export TMUXIFIER_LAYOUT_PATH="$HOME/.config/tmuxifier/layouts"
eval "$(tmuxifier init - zsh)"

# Postgres Client API library
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# 1password zsh completion
# https://developer.1password.com/docs/cli/get-started#shell-completion
eval "$(op completion zsh)"; compdef _op op

# zoxide 
# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

# Make sure coreutils are loaded before system commands
# I've disabled this for now because I only use "ls" which is
# referenced in my aliases.zsh file directly.
#export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

### Project ENV variables ###
