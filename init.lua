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

-- Lazy.nvim Setup
require("lazy").setup({

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
      }
    }
  },
  
})
