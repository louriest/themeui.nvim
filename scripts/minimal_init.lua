vim.cmd([[let &rtp.=','.getcwd()]])

vim.opt.rtp:append(vim.fn.getcwd() .. "/deps/mini.nvim")
vim.opt.rtp:append(vim.fn.getcwd() .. "/deps/nui.nvim")

require("mini.test").setup()
