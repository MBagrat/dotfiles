#!/bin/sh

echo "Cloning repositories..."

WORKSPACE=$HOME/workspace
WORK=$WORKSPACE/work
PERSONAL=$WORKSPACE/personal
WORK_PROJECTS=$WORK/projects
PERSONAL_PROJECTS=$PERSONAL/projects

# Oh My ZSH custom plugins
git clone https://github.com/wbingli/zsh-wakatime.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-wakatime 

# Personal

# Work
