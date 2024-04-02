GPG_TTY=$(tty)

# source $XDG_CONFIG_HOME/zsh/scripts/functions.zsh && eval_brew

# Path to brew installation
HOMEBREW_PREFIX="$(brew --prefix)";
HOMEBREW_CELLAR="$(brew --cellar)";
HOMEBREW_REPOSITORY="$(brew --repository)";
PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin${PATH+:$PATH}";
MANPATH="$(brew --prefix)/share/man${MANPATH+:$MANPATH}:";
INFOPATH="$(brew --prefix)/share/info:${INFOPATH:-}";
