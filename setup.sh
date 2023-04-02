#!/bin/bash

abspath=$(cd -- $(dirname -- ${BASH_SOURCE[0]}) && pwd)

sh -c "curl -fLo ${abspath}/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
if [[ $? != 0 ]]; then
  echo "error curling plug.vim"
  exit 1
fi

rm ~/.config/nvim
ln -s "${abspath}/nvim" ~/.config/nvim
# nvim -S nvim_setup.lua
rm ~/.bashrc
ln -s "${abspath}/bashrc" ~/.bashrc
rm ~/.profile
ln -s "${abspath}/profile" ~/.profile
rm ~/.config/awesome
ln -s "${abspath}/awesome" ~/.config/awesome
rm ~/.config/openbox
ln -s "${abspath}/openbox" ~/.config/openbox
rm ~/wallpapers
ln -s "${abspath}/wallpapers" ~/wallpapers
