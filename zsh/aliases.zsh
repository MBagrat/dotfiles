################################################
# 🔥 #OneDevMinute
#
# Daily one minute developer tips.
################################################

# Config aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias reloadshell="source $HOME/.zshrc"

# Easier directory navigation.
alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."
alias ....="cd ../../../.."
alias cd..=".cd .." # Typo addressed.

alias sl='ls -hula ~ | grep "\->"'

# Always enable colored `grep` output
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Shortcuts
alias c="clear"
alias df="cd $DOTFILES"
alias dt="cd $HOME/Desktop"
alias dl="cd $HOME/Downloads"
alias ws="cd $HOME/workspace"
alias aenv="anyenv"
alias icloud="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs"
alias cssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias buc="brew bundle -g && brew upgrade -g && brew bundle -g --force cleanup"
alias ll="/usr/local/opt/coreutils/libexec/gnubin/ls -AhlFo --color --group-directories-first"

# Mac OS
alias xcode="open -a Xcode"
alias reset-doc="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"

# Project folders
alias mbb="cd $HOME/Workspace/personal/projects/development/mbagrat-blog"
