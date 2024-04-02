# Config aliases
alias zshconfig="vim ~/.zshrc"
alias reloadshell="source $HOME/.zshrc"

# Easier directory navigation.
alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."
alias ....="cd ../../../.."
alias cd..=".cd .." # Typo addressed.

alias sl='ls -hula ~ | grep "\->"'

# exa
if [[ -z $commands[eza] ]]; then
    echo 'eza is not installed. See https://github.com/eza-community/eza'
    return 1
fi

# general use
alias ls='eza'                                                         # ls
alias l='eza -lbF --git'                                               # list, size, type, git
alias ll='eza -lbGF --git'                                             # long list
alias llm='eza -lbGF --git --sort=modified'                            # long list, modified date sort
alias la='eza -lbhHigUmuSa --time-style=long-iso --git --color-scale'  # all list
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list

# speciality views
alias lS='eza -1'                                                      # one column, just names
alias lt='eza --tree --level=2'                                        # tree

# Always enable colored `grep` output
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Shortcuts
alias df="cd $DOTFILES"
alias dt="cd $HOME/Desktop"
alias dl="cd $HOME/Downloads"
alias ws="cd $HOME/workspace"
alias icloud="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs"

# Mac OS
alias c="clear"
alias vim="nvim"
alias aenv="anyenv"
alias xcode="open -a Xcode"
alias cssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias reset-doc="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias rmds="find . -name ".DS_Store" -depth -exec rm -f {} \;"

# Project folders
## Personal
alias mbb="cd $HOME/Workspace/personal/projects/development/mbagrat-blog"
