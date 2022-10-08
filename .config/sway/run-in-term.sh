#! /bin/sh

command="$(history | awk 'NR <=100' | rofi -dmenu -theme ~/.config/rofi/dmenu.rasi -p 'Command (in terminal):')"

if [[ -z $command ]]; then
    exit
fi

exec alacritty -e fish -c $command
