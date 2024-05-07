export GPG_TTY=$(tty)

# source $XDG_CONFIG_HOME/zsh/scripts/functions.zsh && eval_brew

# Path to brew installation
export HOMEBREW_PREFIX="$(brew --prefix)";
export HOMEBREW_CELLAR="$(brew --cellar)";
export HOMEBREW_REPOSITORY="$(brew --repository)";
export PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin${PATH+:$PATH}";
export MANPATH="$(brew --prefix)/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="$(brew --prefix)/share/info:${INFOPATH:-}";
