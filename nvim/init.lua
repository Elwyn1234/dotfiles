require("elwyn")

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.o.relativenumber = true
vim.o.number = true

vim.g.delme = "delme"

if (vim.fn.has("termguicolors")) then
  vim.o.termguicolors = true
end
-- vim.cmd('syntax enable') -- I don't think we need this because we have treesitter
vim.cmd('colorscheme night-owl')

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
