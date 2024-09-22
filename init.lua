vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Options ]] --
-- line number
vim.opt.number = true
vim.opt.relativenumber = true

-- tabs and spaces
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.shiftwidth = 2

-- Lazy.nvim Installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]] --
-- Lazy.nvim Setup
require("lazy").setup({

  -- Oxocarbon Colorscheme
  'nyoom-engineering/oxocarbon.nvim',

  -- LaTex
  {
    'lervag/vimtex',
    lazy = false,
  },
  'micangl/cmp-vimtex',

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "c",
        "cpp",
        "lua",
        "html",
        "css",
        "vim",
        "vimdoc",
      }
    }
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },

  -- Completions
  {
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
  },

})

-- [[ Setup ]] --
-- Colorscheme
vim.opt.background = "dark" -- set this to dark or light
vim.cmd.colorscheme "oxocarbon"

-- LSP Setup
require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = { "lua_ls", "clangd", "texlab" },
}

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp = require("lspconfig")
lsp.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
  capabilities = lsp_capabilities,
})
lsp.clangd.setup({
  capabilities = lsp_capabilities,
})
lsp.texlab.setup({
  capabilities = lsp_capabilities,
})

-- Completions Setup
local cmp = require('cmp')
cmp.setup({
  sources = {
    {name = 'nvim_lsp', 'vimtex' },
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    -- confirm completion
    ['<Tab>'] = cmp.mapping.confirm({select = true}),

    -- Next Prev Items
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k'] = cmp.mapping.select_prev_item(),
    -- scroll up and down the documentation window
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),

})
