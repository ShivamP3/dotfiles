function screenshot
    mkdir -p $HOME/Pictures/Screenshots
    grim $HOME/Pictures/Screenshots/(date +%+m:%+d:%+Y_%+H:%+M:%+S).png
end
