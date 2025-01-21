print("init.lua loaded!")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.shiftwidth = 4

require("config.remap")
require("config.lazy")
