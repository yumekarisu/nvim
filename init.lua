print("init.lua loaded!")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.shiftwidth = 4

require("config.remap")
require("config.lazy")

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function ()
    	vim.highlight.on_yank()
    end,
})
