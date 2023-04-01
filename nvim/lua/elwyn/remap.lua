vim.g.mapleader = " "
vim.keymap.set("n", "<leader>p", vim.cmd.Ex)

-- These allow you to move selections
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Centre the cursor's line when jumping with 'n'
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- leader p / d deletes the selection to the void register
vim.keymap.set("v", "<leader>p", '"_dP')
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>d", '"_d') -- cant get this to work

-- leader y yanks to the clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y') -- cant get this to work
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>Y", '"+Y')

-- leader x makes the current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true}) -- cant get this to work

-- Apparently quick fix is good
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Buffer next
vim.keymap.set("n", "<leader>bn", "<cmd>bn<CR>")
vim.keymap.set("n", "<leader>bp", "<cmd>bp<CR>")

-- Fold class or Go function
vim.keymap.set("n", "<leader>zc", "/class<CR>zfa{")
vim.keymap.set("n", "<leader>zf", "/func<CR>zfa{")
