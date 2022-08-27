#! /bin/bash

export DOTFILES = /home/shivam/dotfiles
sh -c "export DOTFILES = /home/shivam/dotfiles"

# install yay
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# install packages
yay -S $(cat pacman-list)
yay -S $(cat aur-list)

# symlink configs
cd $DOTFILES
./make-symlinks.sh
