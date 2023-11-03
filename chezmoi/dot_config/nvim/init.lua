vim.g.mapleader = ' '
vim.g.loaded_netrw = 1        -- NOTE: this might help with neo-tree
vim.g.loaded_netrwPlugin = 1  -- NOTE: this might help with neo-tree

vim.o.autoindent = true
vim.o.clipboard = 'unnamedplus'
vim.o.cmdheight = 2 -- NOTE: allows hardtime to display alongside modes
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
    end,
  },
  {
    'NvChad/nvim-colorizer.lua',
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
    'folke/todo-comments.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    opts = {},
  },
  {
    'numToStr/Comment.nvim',
    config = true,
  },
  {
    'alker0/chezmoi.vim',
    lazy = false,
    init = function()
      vim.g['chezmoi#source_dir_path'] = '~/dotfiles/chezmoi'
      vim.g['chezmoi#use_tmp_buffer'] = true
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter').setup({'nvim-treesitter/nvim-treesitter',
      build = 'TSUpdate'})
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
    'nvim-neorg/neorg',
    build = ':Neorg sync-parsers', -- BUG: does not seem to trigger properly, complains on first run
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {}, -- Loads default behaviour
          ['core.concealer'] = {}, -- Adds pretty icons to your documents
          ['core.dirman'] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                dotfiles = '~/dotfiles/org',
              },
              default_workspace = 'dotfiles'
            },
          },
        },
      }
      vim.wo.conceallevel = 2 -- TODO: difference between vim.o and vim.wo
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
  -- {
  --   'xiyaowong/transparent.nvim',
  --   config = true,
  -- },
  -- {
  --   'folke/twilight.nvim', -- BUG: does nothing
  --   config = true,
  -- },
  -- {
  --   'lcheylus/overlength.nvim',
  --   config = true,
  -- },
  -- {
  --   'xiyaowong/transparent.nvim',
  --   config = function()
  --     require('transparent').setup {
  --       extra_groups = {
  --         'NeoTreeNormal',
  --         'NeoTreeNormalNC',
  --         'NormalFloat',
  --       },
  --    }
  --   end,
  -- },
  -- {
  --   "m4xshen/hardtime.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {
  --     enabled = false,
  --   }
  -- },
  -- {
  -- 'nvim-pack/nvim-spectre',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim'
  --   },
  -- config = function()
  --   require('spectre').setup({
  --     live_update = true,
  --     replace_vim_cmd = 'cdfo',
  --     })
  --   end,
  -- },
  -- {
  -- 'akinsho/toggleterm.nvim',
  -- config = function()
  --   require('toggleterm').setup({
  --     shade_terminals = false,
  --     })
  --   end,
  -- },
  defaults = {
    lazy = true,
    version = '*',
  },
})

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- see :help lsp-zero-guide:integrate-with-mason-nvim
-- to learn how to use mason.nvim with lsp-zero
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'bashls',   -- bash, sh, zsh
    'biome',    -- json but supports more
    'lua_ls',   -- lua
    'pyright',  -- python
    'taplo',    -- toml
    'yamlls',   -- yaml
  },
  handlers = {
    lsp_zero.default_setup,
  }
})

require('lspconfig')['bashls'].setup{
	filetypes = {
    'bash',
    'sh',
    'zsh',
  },
}
