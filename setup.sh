#!/bin/bash

abs_path=$(cd -- $(dirname -- ${BASH_SOURCE[0]}) && pwd)
ln -s "${abs_path}/nvim" ~/.config/nvim
# nvim -S nvim_setup.lua
