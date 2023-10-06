-- MAPPINGS
local sk = vim.api.nvim_set_keymap

sk('n', 'j', 'gj', { noremap = true, silent = true })
sk('n', 'k', 'gk', { noremap = true, silent = true })
sk('v', 'j', 'gj', { noremap = true, silent = true })
sk('v', 'k', 'gk', { noremap = true, silent = true })
sk('n', ',<space>', ':nohlsearch<CR>', { noremap = true, silent = true })
sk('n', '<C-H>', '<C-W>h', { noremap = false, silent = true })
sk('n', '<C-L>', '<C-W>l', { noremap = false, silent = true })
sk('n', '=', '<C-W>=', { noremap = false, silent = true })
sk('n', '+', '<C-W>+', { noremap = false, silent = true })
sk('n', '-', '<C-W>-', { noremap = false, silent = true })
sk('n', '<M-w>', ':bd!<CR>', { noremap = false, silent = true }) 
sk('', '<C-j>', '5j', { noremap = true, silent = true})
sk('', '<C-k>', '5k', { noremap = true, silent = true})

-- fzf
sk('n', ',t', ':Files<CR>', { noremap = true, silent = true })
sk('n', "'", ':Buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_var('fzf_preview_window', 'right:50%:bottom')

-- emmit
vim.api.nvim_set_var('user_emmet_leader_key', '<C-A>')
