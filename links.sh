#!/bin/sh

create_link() {
	if [ -f $1 ] || [ -d $1 ]; then
		rm -rf $2
	fi

	if [ -f $1 ] || [ -d $1 ]; then
    ln -s $1 $2
	else
		print "404: ${1} not found."
	fi
}

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles/zsh
create_link $DOTFILES/zsh/.zshrc $HOME/.zshrc
# Removes .zprofile from $HOME (if it exists) and symlinks the .zprofile file from the .dotfiles/zsh
create_link $DOTFILES/zsh/.zprofile $HOME/.zprofile
# Removes .zshenv from $HOME (if it exists) and symlinks the .zshenv file from the .dotfiles/zsh
create_link $DOTFILES/zsh/.zshenv $HOME/.zshenv

# Removes .bashrc from $HOME (if it exists) and symlinks the .bashrc file from the .dotfiles/bash
create_link $DOTFILES/bash/.bashrc $HOME/.bashrc
# Removes .bash_profile from $HOME (if it exists) and symlinks the .bash_profile file from the .dotfiles/bash
create_link $DOTFILES/bash/.bash_profile $HOME/.bash_profile
# Removes .profile from $HOME (if it exists) and symlinks the .profile file from the .dotfiles/bash
create_link $DOTFILES/bash/.profile $HOME/.profile

# Removes .mackup.cfg from $HOME (if it exists) and symlinks the .mackup.cfg file from the .dotfiles
create_link $DOTFILES/.mackup.cfg $HOME/.mackup.cfg

# Removes .gitconfig from $HOME (if it exists) and symlinks the .gitconfig file from the .dotfiles/git
create_link $DOTFILES/git/.gitconfig $HOME/.gitconfig
# Removes .gitattributes from $HOME (if it exists) and symlinks the .gitattributes file from the .dotfiles/git
create_link $DOTFILES/git/.gitattributes $HOME/.gitattributes
# Removes global .gitignore from $HOME (if it exists) and symlinks the global .gitignore file from the .dotfiles/git
create_link $DOTFILES/git/.gitignore $HOME/.gitignore

# Removes global .tmux.conf from $HOME (if it exists) and symlinks the global .tmux.conf file from the .dotfiles/tmux
create_link $DOTFILES/tmux/.tmux.conf $HOME/.tmux.conf

# Removes global .vimrc from $HOME (if it exists) and symlinks the global .vimrc file from the .dotfiles/vim
create_link $DOTFILES/vim $HOME/.vim
create_link $DOTFILES/vim/.vimrc $HOME/.vimrc

# Removes nvim folder from $HOME/.config (if it exists) and symlinks the global nvim folder from the .dotfiles/nvim
create_link $DOTFILES/nvim/ $HOME/.config/nvim

ls -hula ~ | grep "\->"