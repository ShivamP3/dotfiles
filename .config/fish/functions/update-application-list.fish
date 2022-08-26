function update-application-list
	pacman -Qqen > $DOTFILES/pacman-list
	pacman -Qqm > $DOTFILES/aur-list
	cargo install --list | awk '/^\w/ { print $1 }' | awk NF=1 > /home/shivam/dotfiles/cargo-list
	pip freeze > $DOTFILES/pip-list
end
