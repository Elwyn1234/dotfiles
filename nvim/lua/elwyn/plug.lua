local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('neoclide/coc.nvim', {branch = 'release'})
Plug('haishanh/night-owl.vim')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.0' })
Plug('windwp/nvim-autopairs')
-- Plug 'jiangmiao/auto-pairs' What I used to use for autopairs (are both good?)
Plug('lukas-reineke/indent-blankline.nvim')
Plug('nvim-treesitter/nvim-treesitter', { run = 'TSUpdate' })
Plug('nvim-treesitter/playground')
Plug('theprimeagen/harpoon')
Plug('mbbill/undotree')
Plug('tpope/vim-fugitive')
Plug 'tpope/vim-commentary'
vim.call('plug#end')

require("nvim-autopairs").setup {}
