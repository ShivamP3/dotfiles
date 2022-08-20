function screenshot-monitor
    mkdir -p $HOME/Pictures/Screenshots
     grim -o (swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') $HOME/Pictures/Screenshots/(date +%+m:%+d:%+Y_%+H:%+M:%+S).png
end
