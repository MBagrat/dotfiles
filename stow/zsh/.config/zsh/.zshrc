#!/bin/sh

# scripts
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/scripts/exports.zsh"
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/scripts/functions.zsh"

# zap - zsh plugin manager install location
[[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ]] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# plugins
plug "romkatv/powerlevel10k"
plug "hlissner/zsh-autopair"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "zap-zsh/exa"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-completions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
plug "MichaelAquilina/zsh-you-should-use"

# themes
plug "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/themes/p10k.zsh"
# aliasses
plug "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases/aliases.zsh"
plug "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases/omz/git/git.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/p10k.zsh" ]] || source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/p10k.zsh" 
