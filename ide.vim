augroup lsp
    autocmd!
    au BufEnter * filetype detect
    au FileType lua lua require('lsp-config').start_lua_ls()
    au FileType cpp lua require('lsp-config').start_clangd()
    au FileType python lua require('lsp-config').start_pylsp()
augroup END


