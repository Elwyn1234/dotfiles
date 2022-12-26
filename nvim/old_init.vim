" This is my old powershell config that might have some useful settings if I
" ever go back to powershell
"
" \/ no idea what this does \/
let &shell = "powershell"
let &shellquote = ""
let &shellxquote = ""
let &shellpipe = "2>&1 | Tee-Object"
let &shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
let &shellredir = "| Out-File -Encoding UTF8"

let g:coc_node_path = 'C:\Program Files (x86)\nodejs\node.exe'

hi Normal ctermbg=none
" /\ no idea what this does /\


set rnu nu
set cindent
set tabstop=2 softtabstop=2 expandtab shiftwidth=2
set colorcolumn=80
set directory=$HOME/vimfiles/.swp/ "think this puts swp files here so that they dont populate cwd. Careful, maybe this also changes the location of other stuff or where things like local settings are sourced from.

call plug#begin('C:\Users\elwyn\AppData\Local\nvim-data\plugged')
" Consider getting treesitter. Last time i tried it was a pain
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
call plug#end() 

if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme night-owl "This scheme was downloaded manually because apparently Plug just isnt nice on windows or something

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
