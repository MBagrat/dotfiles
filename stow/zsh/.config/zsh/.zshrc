#!/bin/sh

# Zsh configuration file for command line completion (zcompdump) 
ZSH_COMPDUMP=$HOME/.cache/zsh/zcompdump-$HOST

# zap - zsh plugin manager install location
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

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
plug "$HOME/.config/zsh/scripts/history.zsh"
plug "$HOME/.config/zsh/scripts/functions.zsh"
# themes
plug "$HOME/.config/zsh/themes/p10k.zsh"
# aliasses
plug "$HOME/.config/zsh/aliases/aliases.zsh"
plug "$HOME/.config/zsh/aliases/omz/git/git.zsh"
