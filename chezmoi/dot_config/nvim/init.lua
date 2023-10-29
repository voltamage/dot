vim.g.mapleader = ' '
vim.g.loaded_netrw = 1        -- NOTE: this might help with neo-tree
vim.g.loaded_netrwPlugin = 1  -- NOTE: this might help with neo-tree

vim.o.autoindent = true
vim.o.clipboard = 'unnamedplus'
vim.o.expandtab = true
vim.o.mouse = 'a'
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.termguicolors = true -- NOTE: relied on by neo-tree
vim.o.wrap = false


local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-fugitive',
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme gruvbox-material')
--      vim.cmd('g:gruvbox_material_transparent_background = 1')
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup(nil,{
        RGB       = true,
        RRGGBB    = true,
        RRGGBBAA  = true,
        hsl_fn    = true,
        mode      = 'background',
        names     = false,
        rgb_fn    = true,
      })
    end,
  },
  {
    'xiyaowong/transparent.nvim',
    config = function()
      require('transparent').setup {
        extra_groups = {
          'NeoTreeNormal',
          'NeoTreeNormalNC',
          'NormalFloat',
        },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter').setup({'nvim-treesitter/nvim-treesitter', build = 'TSUpdate'})
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    config = true,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    opts = {},
  },
  {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {},
  },
  {
  'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-treesitter/nvim-treesitter',
    },
    config = true,
  },
  {
  'nvim-pack/nvim-spectre',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
  config = function()
    require('spectre').setup({
      live_update = true,
      replace_vim_cmd = 'cdfo',
      })
    end,
  },
  {
  'akinsho/toggleterm.nvim',
  config = function()
    require('toggleterm').setup({
      shade_terminals = false,
      })
    end,
  },
  {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/nvim-cmp',
      'neovim/nvim-lspconfig',
      'williamboman/mason-lspconfig.nvim',
      'williamboman/mason.nvim',
    },
  },
  defaults = {
    lazy = true,
    version = '*',
  },
})
