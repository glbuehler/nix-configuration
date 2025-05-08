local path = function()
    if vim.api.nvim_buf_get_option(0, 'filetype') == 'netrw' then
        return vim.b.netrw_curdir
    else
        return vim.fn.expand('%:t')
    end
end

return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            theme = 'auto',
        },
        sections = {
            lualine_c = { path },
        },
    },
}
