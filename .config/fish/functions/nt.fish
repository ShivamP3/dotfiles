function nt --description 'Runs arguments in a new terminal'
    alacritty -e fish -c $argv &
end
