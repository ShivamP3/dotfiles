function sesh_anc
    sudo systemctl start bluetooth
    bluetoothctl connect 30:53:C1:02:A6:A8
end
