# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

# Load binaries from sbin
export PATH="/usr/local/sbin/:$PATH"

# Load dotfiles binaries
export PATH="$DOTFILES/bin:$PATH"

# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

# Load chroma binary only for oh-my-zsh plugin colorize
export PATH="/usr/local/Cellar/chroma:$PATH"

# jEnv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# openssl
export PATH=$PATH:/usr/local/Cellar/openssl@1.1/1.1.1k/lib

# ZSH plugin for wakatime are associated with the Terminal project, 
# if you would like the plugin to attribute the project based on 
# either git repository or the last accessed project then set
export ZSH_WAKATIME_PROJECT_DETECTION=true

# Make sure coreutils are loaded before system commands
# I've disabled this for now because I only use "ls" which is
# referenced in my aliases.zsh file directly.
#export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
