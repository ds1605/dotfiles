#!/usr/bin/env bash

### ---------------------- ###
### - Dotfiles installer - ###
### ---------------------- ###

# Author - ds1605@github.com

### Variables
DIR_BASE="$(pwd)"
DIR_INSTALL="${HOME}"



### Functions
function link_install() {
    # Source file, link location

    # Check if previous files exist
    # Make a backup of previous files, and then remove previous files
    echo "Removing ${2}..."
    rm -rf $2
    
    # Link files
    echo "Linking ${1} to ${2}..."
    ln -s $1 $2
    # chmod u+x ${2}
    return 0
}



### Installation
## Shell and Terms
link_install "${DIR_BASE}/shell/profile" "${DIR_INSTALL}/.profile"
for i in {antigen.zsh,pastefix.zsh,powerline.zsh,zshrc}
do
	link_install "${DIR_BASE}/shell/zsh/${i}" "${DIR_INSTALL}/.${i}"
done
link_install "${DIR_BASE}/tmux/tmux.conf" "${DIR_INSTALL}/.tmux.conf"
# Kitty
for i in {kitty.conf,theme.conf}
do
	link_install "${DIR_BASE}/config/kitty/${i}" "${DIR_INSTALL}/.config/kitty/${i}"
done
# Termite
for i in config
do
    link_install "${DIR_BASE}/config/termite/${i}" "${DIR_INSTALL}/.config/termite/${i}"
done

## Desktop
# Compositor
link_install "${DIR_BASE}/config/picom/picom.conf" "${DIR_INSTALL}/.config/picom/picom.conf"
# Awesome
link_install "${DIR_BASE}/desktop/awesome" "${DIR_INSTALL}/.config/awesome"

