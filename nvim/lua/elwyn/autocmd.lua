local storefolds = function(event) 
  -- if string.match(event.match, '[<>:"/\\|?*]') then
  --   return
  -- end
  vim.cmd("silent! mkview")
end

local loadfolds = function() 
  vim.cmd('silent! loadview')
end

vim.api.nvim_create_autocmd({"BufWinEnter"}, {callback = loadfolds})
vim.api.nvim_create_autocmd({"BufWinLeave"}, {callback = storefolds})
