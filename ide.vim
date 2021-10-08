augroup lsp
    autocmd!
    au BufEnter * filetype detect
    au FileType lua lua require('lsp-config').start_lua_ls()
augroup END


