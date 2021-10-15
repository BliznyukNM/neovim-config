call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" This plugin provides a start screen for Vim and Neovim.
Plug 'mhinz/vim-startify'

" This is yet another Solarized theme for Vim.
Plug 'lifepillar/vim-solarized8'

" All the lua functions I don't want to write twice. 
Plug 'nvim-lua/plenary.nvim'

" Gaze deeply into unknown regions using the power of the moon.
Plug 'nvim-telescope/telescope.nvim'

" All in one neovim plugin that provides superior project management.
Plug 'ahmedkhalf/project.nvim'

" A Magit clone for Neovim that is geared toward the Vim philosophy.
" Plug 'TimUntersberger/neogit'
" A collection of common configurations for built-in language server client.
Plug 'neovim/nvim-lspconfig'

" Fast as fuck completion
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}

" 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" Godot plugin for syntax
Plug 'habamax/vim-godot'

" Autocomplete brackeys
Plug 'jiangmiao/auto-pairs'

Plug 'mfussenegger/nvim-jdtls'

call plug#end()