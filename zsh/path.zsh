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

# jEnv (Master your Java Environment with jenv)
# https://github.com/jenv/jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# nvm (Node Version Manager)
# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
# This loads nvm bash_completion
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# rbenv (Seamlessly manage your app’s Ruby environment with rbenv.)
# https://github.com/rbenv/rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
export RUBY_CONFIGURE_OPTS=${"--with-openssl-dir=$(brew --prefix openssl@1.1)"}
eval "$(rbenv init - zsh)"
# Ruby GEM
export GEM_HOME=${"$(ruby -e 'puts Gem.user_dir')"}
export PATH="$GEM_HOME/bin:$PATH"

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
