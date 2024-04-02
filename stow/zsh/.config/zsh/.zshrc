#!/bin/sh

[ -d "${XDG_CACHE_HOME}/zsh/history/" ] || mkdir -p "${XDG_CACHE_HOME}/zsh/history/"
[ -d "${XDG_CACHE_HOME}/zsh/compdump/" ] || mkdir -p "${XDG_CACHE_HOME}/zsh/compdump/"

# History file configuration
HISTFILE="${XDG_CACHE_HOME}/zsh/history/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

# History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history Data

# Completion configuration
autoload -Uz compinit -d "${XDG_CACHE_HOME}/zsh/compdump/.zcompdump-${HOST}-${ZSH_VERSION}"
compinit -C -d "${XDG_CACHE_HOME}/zsh/compdump/.zcompdump-${HOST}-${ZSH_VERSION}"

# zap - zsh plugin manager install location
[ -f "${XDG_DATA_HOME}/zap/zap.zsh" ] && source "${XDG_DATA_HOME}/zap/zap.zsh"

# plugins
plug "romkatv/powerlevel10k"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "zap-zsh/vim"
# plug "zap-zsh/zap-prompt"
# plug "zap-zsh/atmachine-prompt" 
plug "zap-zsh/fzf"
plug "zap-zsh/exa"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-completions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
plug "MichaelAquilina/zsh-you-should-use"

# scripts
plug "$HOME/.config/zsh/scripts/exports.zsh"
plug "$HOME/.config/zsh/scripts/functions.zsh"
# themes
plug "$HOME/.config/zsh/themes/p10k.zsh"
# aliasses
plug "$HOME/.config/zsh/aliases/aliases.zsh"
plug "$HOME/.config/zsh/aliases/omz/git/git.zsh"
