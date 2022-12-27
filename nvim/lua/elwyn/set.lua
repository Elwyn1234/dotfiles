vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.o.relativenumber = true
vim.o.number = true

vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- TODO: HOME not defined on windows
vim.opt.undofile = true

vim.o.termguicolors = true
-- vim.cmd('syntax enable') -- I don't think we need this because we have treesitter
vim.cmd('colorscheme night-owl')
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- vim.opt.scrolloff = 0 This sets no vertical padding when scrolling

-- vim.opt.updatetime = 50 Maybe we want coc to display function info when we hover them
