let autodetected = ['java']
augroup lsp
    autocmd!
    au BufEnter * if index(autodetected, &ft) < 0 | filetype detect
    au FileType lua lua require('lsp-config').start_lua_ls()
    au FileType cpp lua require('lsp-config').start_clangd()
    au FileType python lua require('lsp-config').start_pylsp()
    au FileType java lua require('lsp-config').start_jdt()
    au FileType xml,xsd,svg lua require('lsp-config').start_lemminx()
augroup END


