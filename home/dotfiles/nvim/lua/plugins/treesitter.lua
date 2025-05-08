return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
        highlight = { enable = true },
        indent = { enable = true, disable = { 'html' } },
        auto_install = true,
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end,
}
