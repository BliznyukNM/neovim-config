" color scheme
" set background=dark
" colorscheme solarized8

" set tab size to 4 spaces
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

lua << EOF
-- Set leader key to <Space>
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Telescope settings
local telescope = require('telescope')
local ignore_patterns = {'%.png', '%.meta', '%Library/*'}
telescope.setup {
    defaults = {
        file_ignore_patterns = ignore_patterns
    }
}
EOF

" Telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
