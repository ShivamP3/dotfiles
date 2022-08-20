#! /bin/sh

layout=$(swaymsg -t get_inputs | grep -m1 'xkb_active_layout_name' | cut -d \" -f4)

case $layout in
    "English\/Intl (Colemak, edition DreymaR)") echo "Colemak";;
    "English (US)") echo "QWERTY";;
    *) echo $layout;;
esac
