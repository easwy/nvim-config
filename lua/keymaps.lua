-- define common options
local opts = {
    noremap = true,
    silent = true,
}

-- Normal mode
vim.keymap.set('n', '<leader>ww', ':w<CR>', opts)
vim.keymap.set('n', '<leader>ee', ':e ~/.config/nvim/init.lua<CR>', opts)
vim.keymap.set('n', '<leader><cr>', ':noh<cr>', opts)

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
-- vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
-- vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
-- vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
-- vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Visual mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Search cword under cursor to location list
vim.keymap.set('n', '<leader>lv', function()
    local cword = vim.fn.escape(vim.fn.expand('<cword>'), [[\/]])
    local pattern = string.format([[\<%s\>]], cword)
    vim.cmd('silent! lvimgrep /' .. pattern .. '/ %')
    vim.cmd('lopen')
end, { noremap = true, silent = true, desc = 'Search word in loclist' })

-- Search visual selected text to location list
vim.keymap.set('v', '<leader>lv', function()
    vim.cmd('noau normal! "vy"')
    local selected_text = vim.fn.getreg('v')
    local escaped_text = vim.fn.escape(selected_text, [[\/~.^$[]*]])
    local pattern = string.format([[%s]], escaped_text)
    vim.cmd('silent! lvimgrep /' .. pattern .. '/ %')
    vim.cmd('lopen')
    vim.cmd('match Search /' .. pattern .. '/')
    vim.defer_fn(function()
        vim.cmd('match none')
    end, 2000)
end, { noremap = true, silent = true, desc = 'Search visual selection in loclist' })

-- Mark plugins (if installed)
vim.keymap.set('n', '<leader>hl', '<Plug>MarkSet', opts)
vim.keymap.set('x', '<leader>hl', '<Plug>MarkSet', opts)
vim.keymap.set('n', '<leader>hc', ':MarkClear<CR>', opts)
