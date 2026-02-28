-- Install Packer automatically if it's not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- Reload configurations if we modify plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local packer = require('packer')
local util = require('packer.util')

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack'),
})

-- Install plugins here
return packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  ---------------------------------------
  -- NOTE: PUT YOUR THIRD PLUGIN HERE --
  ---------------------------------------
  use { 'tanvirtin/monokai.nvim' }
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use { 'neovim/nvim-lspconfig' }
  use { 'hrsh7th/nvim-cmp', config = [[require('config.nvim-cmp')]] }
  use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'onsails/lspkind-nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'BurntSushi/ripgrep' }
  use { 'nvim-telescope/telescope.nvim',
        tag = 'v0.2.1',
        requires = { 'nvim-lua/plenary.nvim' }
  }
  use { 'nvim-telescope/telescope-file-browser.nvim',
        requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-treesitter/nvim-treesitter',
        run = function()
          require('nvim-treesitter.install').update({ with_sync = true })
        end,
  }
  use { 'stevearc/aerial.nvim',
        config = function() require('aerial').setup() end
  }
  use { 'vim-airline/vim-airline' }
  use { 'vim-airline/vim-airline-themes' }
  use { 'liuchengxu/vista.vim' }
  use { 'chentoast/marks.nvim' }
  use { 'jlanzarotta/bufexplorer' }
  use { 'p00f/clangd_extensions.nvim' }
  -- use { 'vim-scripts/winmanager' }
  -- use { 'vim-scripts/ShowMarks' }
  use { 'preservim/nerdcommenter' }
  use { 'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        requires = { 'nvim-lua/plenary.nvim' }
  }
  use { 'tpope/vim-projectionist' }
  use { 'tpope/vim-dispatch' }
  use { 'inkarkat/vim-mark',
    requires = { 'inkarkat/vim-ingo-library' }
  }
  use { 'folke/trouble.nvim' }
  use { 'nvim-tree/nvim-web-devicons' }
  use { 'nvim-tree/nvim-tree.lua' }
  use { 'olimorris/codecompanion.nvim',
        requires = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
