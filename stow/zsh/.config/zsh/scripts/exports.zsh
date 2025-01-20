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

export PATH="${HOMEBREW_PREFIX}/share/flutter/bin:$PATH"

# 1password zsh completion
# https://developer.1password.com/docs/cli/get-started#shell-completion
eval "$(op completion zsh)"; compdef _op op

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----- Bat (better cat) -----

export BAT_THEME=tokyonight_night

# ---- TheFuck -----

# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# ---- Zoxide (better cd) ----
eval "$(zoxide init --cmd cd zsh)"

# Make sure coreutils are loaded before system commands
# I've disabled this for now because I only use "ls" which is
# referenced in my aliases.zsh file directly.
#export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

### Project ENV variables ###
