# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

# Load binaries from sbin
export PATH="/usr/local/sbin/:$PATH"

# Load dotfiles binaries
export PATH="$DOTFILES/bin:$PATH"

# Jetbrains Toolbox script paths
export PATH=$PATH:$HOME/Library/Application\ Support/JetBrains/Toolbox/scripts/

# AWS CLI completion script for Zsh
# https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html
complete -C '/usr/local/bin/aws_completer' aws

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

# https://github.com/rbenv/ruby-build/wiki#macos
# shellcheck disable=SC2155
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"
# Ruby GEM
export GEM_HOME=${"$(ruby -e 'puts Gem.user_dir')"}
export PATH="$GEM_HOME/bin:$PATH"

# Postgres C API library
export PATH="/usr/local/opt/libpq/bin:$PATH"

# 1password zsh completion
# https://developer.1password.com/docs/cli/get-started#shell-completion
eval "$(op completion zsh)"; compdef _op op

# Make sure coreutils are loaded before system commands
# I've disabled this for now because I only use "ls" which is
# referenced in my aliases.zsh file directly.
#export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# Project ENV variables
export npm_config_azure_user_name=op://AmeriaBank/Azure_Devops/username
export npm_config_azure_access_token=op://AmeriaBank/Azure_Devops/access_token_base64
export npm_config_azure_user_email=op://AmeriaBank/Azure_Devops/username