#!/bin/sh

# zap - zsh plugin manager install location
[[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ]] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# scripts
plug "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/scripts/exports.zsh"
plug "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/scripts/functions.zsh"
plug "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/scripts/keymaps.zsh"

# customized plugins
plug "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/supercharge.zsh"

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

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/themes/p10k.zsh" ]] || source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/themes/p10k.zsh"

# eval "$(starship init zsh)"
# export STARSHIP_CONFIG="$HOME/.dotfiles/stow/starship/.config/startship/starship.toml"