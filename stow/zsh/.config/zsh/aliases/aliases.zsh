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

# eza
if [[ -z $commands[eza] ]]; then
    echo 'eza is not installed. See https://github.com/eza-community/eza'
    return 1
fi

# general use
alias l='eza -lbF --git'                                               # list, size, type, git
alias lsh='eza --long --group --group-directories-first --icons --header --time-style long-iso'
alias ls='eza --all --long --group --group-directories-first --icons --header --time-style long-iso'
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
alias my-sb="cd $HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/my-second-brain"

# Mac OS
alias python=python3
alias pip=pip3
alias stow-link="stow -t ~ *"
alias stow-unlink="stow -D -t ~ *"
alias c="clear"
alias vim="nvim"
alias aenv="anyenv"
alias xcode="open -a Xcode"
alias cssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias assh="ssh-add --apple-use-keychain ~/.ssh/id_ed25519"
alias buc="brew update && brew bundle --global && brew bundle cleanup --global --force && brew upgrade --force"
# alias reset-doc="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"
alias reset-doc="sudo find 2>/dev/null /private/var/folders/ -type d -name com.apple.dock.launchpad -exec rm -rf {} +; killall Dock"
alias reload-dns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias rm-ds="find . -name ".DS_Store" -depth -exec rm -f {} \;"

# Project folders
## Personal
alias kc-sd="kc.sh start-dev"
alias mbb="cd $HOME/Workspace/personal/projects/development/mbagrat-blog"
alias oo="cd /Users/mbagrat/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/my-second-brain/"

# Artifactory Environment Variables 
alias load_artifactory_creds='set_artifactory_env'

set_artifactory_env() {
    export ARTIFACTORY_URI="$(op read op://work/azure_devops/credentials/artifactory_uri)"
    export ARTIFACTORY_EMAIL="$(op read op://work/azure_devops/credentials/email)"
    export ARTIFACTORY_USERNAME="$(op read op://work/azure_devops/credentials/user_name)"
    export ARTIFACTORY_PASSWORD="$(op read op://work/azure_devops/credentials/npm_encoded_access_token)"
    echo "Artifactory credentials loaded successfully."
}

alias unload_artifactory_creds='unset_artifactory_env'

unset_artifactory_env() {
    unset ARTIFACTORY_URI
    unset ARTIFACTORY_EMAIL
    unset ARTIFACTORY_USERNAME
    unset ARTIFACTORY_PASSWORD
    echo "Artifactory credentials removed successfully."
}

# AI Environment Variables 
alias load_ai_env='set_ai_env'

set_ai_env() {
    export ANTHROPIC_API_KEY="$(op read op://Personal/anthropic/anthropic_api_key)"
}

alias unload_ai_env='unset_ai_env'

unset_ai_env() {
    unset ANTHROPIC_API_KEY
}
