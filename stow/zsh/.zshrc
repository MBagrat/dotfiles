#!/bin/sh

# zap - zsh plugin manager install location
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# source
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/functions.zsh"

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

plug "$HOME/.config/zsh/p10k.zsh"
plug "$HOME/.config/zsh/aliases/aliases.zsh"
plug "$HOME/.config/zsh/aliases/omz/git/git.zsh"
