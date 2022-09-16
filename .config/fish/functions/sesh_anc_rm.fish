function sesh_anc_rm
    sudo systemctl start bluetooth
    bluetoothctl disconnect 30:53:C1:09:36:8D
    cd
end
