-- vim.g
vim.g.mapleader = ' '

vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.g.netrw_banner = 0

-- prevent delay of <C-c> in sql files
vim.g.ftplugin_sql_omni_key = '<C-j>'

-- vim.opt
vim.opt.number = true

vim.opt.relativenumber = true

vim.opt.shiftwidth = 4

vim.opt.tabstop = 4

vim.opt.expandtab = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 6

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.cursorline = true

-- can increase startup time if not scheduled
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
    vim.cmd('colorscheme tokyonight-night')
end)
