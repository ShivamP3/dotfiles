function screenshot-selected
    mkdir -p $HOME/Pictures/Screenshots
    grim -g (swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"') $HOME/Pictures/Screenshots/(date +%+m:%+d:%+Y_%+H:%+M:%+S).png
end
