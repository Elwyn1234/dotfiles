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
rm ~/.bashrc
ln -s "${abspath}/bashrc" ~/.bashrc
rm ~/.config/awesome
ln -s "${abspath}/awesome" ~/.config/awesome
# nvim -S nvim_setup.lua
