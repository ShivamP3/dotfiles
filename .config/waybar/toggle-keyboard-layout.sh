#! /bin/sh

qwerty_keymap()
{
    sed -i 's/include "$HOME\/\.config\/sway\/keyboard-layout\"/# include "$HOME\/\.config\/sway\/keyboard-layout\"/' ~/.config/sway/config
    exec swaymsg reload
}

colemak_keymap()
{
    sed -i 's/# include "$HOME\/\.config\/sway\/keyboard-layout\"/include "$HOME\/\.config\/sway\/keyboard-layout\"/' ~/.config/sway/config
    exec swaymsg reload
}

layout=$(swaymsg -t get_inputs | grep -m1 'xkb_active_layout_name' | cut -d \" -f4)

case $layout in
    "English\/Intl (Colemak, edition DreymaR)") qwerty_keymap;;
    "English (US)") colemak_keymap;;
    *);;
esac
