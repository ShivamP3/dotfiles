function screenshot-selection
    mkdir -p $HOME/Pictures/Screenshots
    grim -g (slurp) $HOME/Pictures/Screenshots/(date +%+m:%+d:%+Y_%+H:%+M:%+S).png
end
