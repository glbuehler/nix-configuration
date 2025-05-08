vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

local indent_override = {
    html = 2,
}

local keys = {}
for key, _ in pairs(indent_override) do
    table.insert(keys, key)
end

vim.api.nvim_create_autocmd('FileType', {
    desc = 'indent level per file type',
    group = vim.api.nvim_create_augroup('file-specific-indent', { clear = true }),
    pattern = keys,
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    desc = 'disable sql slow C-c',
    group = vim.api.nvim_create_augroup('sql-fast-C-c', { clear = true }),
    pattern = 'sql',
    callback = function()
        vim.keymap.set('i', '<C-c>', '<Esc>', { noremap = true })
    end,
})
