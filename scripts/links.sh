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
create_link $HOME/.dotfiles/zsh/.zshrc $HOME/.zshrc
# Removes .zprofile from $HOME (if it exists) and symlinks the .zprofile file from the .dotfiles/zsh
create_link $HOME/.dotfiles/zsh/.zprofile $HOME/.zprofile
# Removes .zshenv from $HOME (if it exists) and symlinks the .zshenv file from the .dotfiles/zsh
create_link $HOME/.dotfiles/zsh/.zshenv $HOME/.zshenv

# Removes .bashrc from $HOME (if it exists) and symlinks the .bashrc file from the .dotfiles/bash
create_link $HOME/.dotfiles/bash/.bashrc $HOME/.bashrc
# Removes .bash_profile from $HOME (if it exists) and symlinks the .bash_profile file from the .dotfiles/bash
create_link $HOME/.dotfiles/bash/.bash_profile $HOME/.bash_profile
# Removes .profile from $HOME (if it exists) and symlinks the .profile file from the .dotfiles/bash
create_link $HOME/.dotfiles/bash/.profile $HOME/.profile

# Removes .mackup.cfg from $HOME (if it exists) and symlinks the .mackup.cfg file from the .dotfiles
create_link $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Removes .gitconfig from $HOME (if it exists) and symlinks the .gitconfig file from the .dotfiles/git
create_link $HOME/.dotfiles/git/.gitconfig $HOME/.gitconfig
# Removes .gitattributes from $HOME (if it exists) and symlinks the .gitattributes file from the .dotfiles/git
create_link $HOME/.dotfiles/git/.gitattributes $HOME/.gitattributes
# Removes global .gitignore from $HOME (if it exists) and symlinks the global .gitignore file from the .dotfiles/git
create_link $HOME/.dotfiles/git/.gitignore $HOME/.gitignore

# Removes global .tmux.conf from $HOME (if it exists) and symlinks the global .tmux.conf file from the .dotfiles/tmux
create_link $HOME/.dotfiles/tmux/.tmux.conf $HOME/.tmux.conf
# Removes local .tmux.conf.local from $HOME (if it exists) and symlinks the local .tmux.conf.local file from the .dotfiles/tmux
create_link $HOME/.dotfiles/tmux/.tmux.conf.local $HOME/.tmux.conf.local

# Removes global .Brewfile from $HOME (if it exists) and symlinks the global .Brewfile file from the .dotfiles/Brewfile
create_link $HOME/.dotfiles/Brewfile $HOME/.Brewfile

# Removes global .Brewfile from $HOME (if it exists) and symlinks the global .Brewfile file from the .dotfiles/Brewfile
create_link $HOME/.dotfiles/cmus/rc $HOME/.config/cmus/rc

# Removes global .vimrc from $HOME (if it exists) and symlinks the global .vimrc file from the .dotfiles/vim
create_link $HOME/.dotfiles/vim $HOME/.vim
create_link $HOME/.dotfiles/vim/.vimrc $HOME/.vimrc

# Removes nvim folder from $HOME/.config (if it exists) and symlinks the global nvim folder from the .dotfiles/nvim
create_link $HOME/.dotfiles/nvim/ $HOME/.config/nvim

# Removes .p10k.zsh config file from $HOME (if it exists) and symlinks the global .p10k.zsh file from the .dotfiles/zsh
create_link $HOME/.dotfiles/zsh/.p10k.zsh $HOME/.p10k.zsh

# Removes nvim folder from $HOME/.config (if it exists) and symlinks the global nvim folder from the .dotfiles/nvim
create_link $HOME/.dotfiles/npm/.npmrc $HOME/.npmrc

create_link $HOME/.dotfiles/tower/CompareTools $HOME/Library/Application Support/com.fournova.Tower3/CompareTools

create_link $HOME/.dotfiles/warp $HOME/.warp

ls -hula ~ | grep "\->"