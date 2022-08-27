#!/bin/bash
############################
# Creates symlinks
############################

########## Variables

# Config directory
config=~/.config
# Dotfiles directory
dir=~/dotfiles/.config

##########

# get args

ARGS=$(getopt -a --options c:d:o --long "config:,directory:,old-directory:" -- "$@")

eval set -- "$ARGS"

while true; do
  case "$1" in
    -c|--config)
      config="$2"
      shift 2;;
    -d|--directory)
      dir="$2"
      shift 2;;
    --)
      break;;
  esac
done

# create symlinks
for file in $dir/*; do
     # echo $file
     file=${file/$dir}
     # echo $file

    echo "Symlinking $dir/$file to $config/$file"
    ln -s $dir/$file $config/$file
    unlink $dir/$file/$file
    echo
done
