#!/bin/sh

create_link() {
	if [ -f $1 ] && [ -f $2 ]; then
		rm -rf $2
    ln -s $1 $2
	else
		print "404: ${1} not found."
	fi
}

# Removes .gitconfig from $HOME (if it exists) and symlinks the .gitconfig file from the .dotfiles/git
create_link $DOTFILES/git/.gitconfig $HOME/.gitconfig
# Removes .gitattributes from $HOME (if it exists) and symlinks the .gitattributes file from the .dotfiles/git
create_link $DOTFILES/git/.gitattributes $HOME/.gitattributes
# Removes .gitignore_global from $HOME (if it exists) and symlinks the .gitignore_global file from the .dotfiles/git
create_link $DOTFILES/git/.gitignore_global $HOME/.gitignore_global

# Removes .mackup.cfg from $HOME (if it exists) and symlinks the .mackup.cfg file from the .dotfiles
create_link $DOTFILES/.mackup.cfg $HOME/.mackup.cfg
# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
create_link $DOTFILES/zsh/.zshrc $HOME/.zshrc