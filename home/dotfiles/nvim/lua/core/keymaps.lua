vim.keymap.set('n', '<C-c>', function()
    vim.cmd('silent! nohl')
end)

vim.keymap.set('n', ',', 'o<Esc>', { noremap = true })
vim.keymap.set('n', ';', 'O<Esc>', { noremap = true })

vim.keymap.set('n', '<C-j>', ':move +1<CR>')
vim.keymap.set('n', '<C-k>', ':move -2<CR>')

vim.keymap.set('n', 'gj', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', 'gk', vim.diagnostic.goto_prev, { desc = 'Next diagnostic' })
vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = 'Lsp: [A]ctions' })
vim.keymap.set('n', 'dD', 'cc<C-c>', { desc = 'Clear line' })

vim.keymap.set('t', '<C-b>', '<C-\\><C-n>', { desc = 'Change to Normal from Termianl mode' })
