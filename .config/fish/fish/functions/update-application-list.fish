function update-application-list
	pacman -Qqen > $DOTFILES/pacman-list
	pacman -Qqm > $DOTFILES/aur-list
	cargo install --list | awk '/^\w/ { print $1 }' | awk NF=1 > /home/rejyr/dotfiles/cargo-list
	pip freeze > /home/rejyr/dotfiles/pip-list
end
