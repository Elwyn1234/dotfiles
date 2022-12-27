#!/bin/bash

abspath=$(cd -- $(dirname -- ${BASH_SOURCE[0]}) && pwd)

sh -c 'curl -fLo "${abspath}"/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

ln -s "${abspath}/nvim" ~/.config/nvim
# nvim -S nvim_setup.lua
