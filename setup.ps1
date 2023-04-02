$abspath = split-path -parent $MyInvocation.MyCommand.Definition

New-Item -Force -Path ~\.gitconfig -ItemType SymbolicLink -Value ${abspath}/gitconfig
New-Item -Force -Path ~\AppData\local\nvim -ItemType SymbolicLink -Value ${abspath}/nvim
New-Item -Force -Path ~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -ItemType SymbolicLink -Value ${abspath}/settings.json

iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

