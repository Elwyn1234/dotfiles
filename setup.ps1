$abspath = split-path -parent $MyInvocation.MyCommand.Definition

New-Item -Path ~\AppData\local\nvim -ItemType SymbolicLink -Value ${abspath}/nvim

iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
