#!/bin/sh

echo "Setting up your Mac..."

# Check for Oh My Zsh and install if we don't have it
if test ! "$(which omz)"; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! "$(which brew)"; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Vim plugin manager for NeoVim
/bin/sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# JENV CONFIGURATION
jenv add /Library/Java/JavaVirtualMachines/openjdk-8.jdk/Contents/Home/
jenv add /Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home/
jenv add /Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home/

jenv add /Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home

jenv enable-plugin export

jenv versions

jenv global 11

## DATABASE CONFIGURATION
# Set default MySQL root password and auth type
# Currently I am not sure that this command is needed. Maybe I will activate this command after first test
# mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;"

# Create a Sites directory
mkdir "$HOME/workspace"

# Create sites subdirectories
mkdir "$HOME/workspace/personal"
mkdir "$HOME/workspace/work"

# Clone Github repositories
sources ./clone.sh

# Symlinks config files from the .dotfiles folder
sources ./links.sh

# Set macOS preferences - we will run this last because this will reload the shell
# source ..macos
