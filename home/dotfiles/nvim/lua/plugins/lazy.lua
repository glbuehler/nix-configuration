local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    require('plugins.cmp'),
    require('plugins.conform'),
    require('plugins.gitsigns'),
    require('plugins.harpoon'),
    require('plugins.lspconfig'),
    require('plugins.lualine'),
    require('plugins.mason'),
    require('plugins.mason_tool_installer'),
    require('plugins.telescope'),
    require('plugins.treesitter'),
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },
    {
        'windwp/nvim-ts-autotag',
        opts = {},
        lazy = false,
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,
    },
    {
        'barrett-ruth/live-server.nvim',
        build = 'npm i -g live-server',
        cmd = { 'LiveServerStart', 'LiveServerStop' },
        config = true,
    },
})
