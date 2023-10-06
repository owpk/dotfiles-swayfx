-- MAPPINGS
vim.api.nvim_set_keymap('n', '<C-n>', 'g:NERDTree.IsOpen() ? ":NERDTreeClose<CR>" : bufexists(expand(\'%\')) ? ":NERDTreeFind<CR>" : ":NERDTree<CR>"', { noremap = true, silent = true, expr = true})
vim.api.nvim_set_var('NERDTreeShowHidden', '1')
