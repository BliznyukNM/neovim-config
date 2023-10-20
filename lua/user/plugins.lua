local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "akinsho/bufferline.nvim" -- Tabs like in VSCode
  use "moll/vim-bbye" -- Closing buffers without killing window
  use 'nvim-lualine/lualine.nvim' -- Line on the bottom
  use "ahmedkhalf/project.nvim" -- Project manager
  use "lukas-reineke/indent-blankline.nvim" -- Identetional lines
  use "antoinemadec/FixCursorHold.nvim" -- Fix fos lsp hold buffer performance
  use "folke/which-key.nvim" -- Shortcuts explorer
  use "akinsho/toggleterm.nvim" -- Terminal window
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'kyazdani42/nvim-tree.lua' -- Project tree browser

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"
  use { "catppuccin/nvim", as = "catppuccin" }
  use "f-person/auto-dark-mode.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- LSP snippets

  -- obsidian
  use "epwalsh/obsidian.nvim"

  -- DAP
  use "mfussenegger/nvim-dap" -- main DAP plugin
  use "rcarriga/nvim-dap-ui"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  use "theHamsta/nvim-dap-virtual-text" -- virtual text for DAP

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "BliznyukNM/nim.nvim" -- nim plugin for LSP
  use 'williamboman/mason.nvim' -- Installer for LSP and DAP servers
  use 'williamboman/mason-lspconfig.nvim' -- LSP wrapper
  use "jay-babu/mason-null-ls.nvim"
  use {'Issafalcon/lsp-overloads.nvim'} -- To see all overloads

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use 'nvim-telescope/telescope-media-files.nvim'
  use 'nvim-telescope/telescope-dap.nvim'

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- AI
  -- use 'Exafunction/codeium.vim'
  use 'zbirenbaum/copilot.lua'

  -- Git
  use "lewis6991/gitsigns.nvim"
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

  -- Utils
  use 'rcarriga/nvim-notify'
  use "AckslD/nvim-neoclip.lua"
  use 'stevearc/dressing.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
