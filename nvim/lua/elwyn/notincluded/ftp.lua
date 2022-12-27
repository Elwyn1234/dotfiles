function ftpUpload()
  vim.fn.jobstart('lftp -e "put -O /public_html/web2/ ' .. vim.fn.expand('%:S') .. '; exit" -u ejohn,P@ssw0rd12 digitech.ncl-coll.ac.uk')
end

vim.api.nvim_create_autocmd({'BufWritePost'}, {callback = ftpUpload})
