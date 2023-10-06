local actions = require "fzf-lua.actions"

require'fzf-lua'.setup {
  fzf_colors = {
    ["fg"] = { "fg", "Normal" },
    ["bg"] = { "bg", "Normal" },
    ["fg+"] = { "fg", "Normal" },
    ["bg+"] = { "bg", "Normal" },  
  },
  winopts = {
    preview = {
      hidden = 'nohidden',
    },
  },
}

-- MAPPINGS
vim.api.nvim_set_keymap('n', ',t',
  "<cmd>lua require('fzf-lua').files()<CR>",
  { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', "'",
  "<cmd>lua require('fzf-lua').buffers()<CR>",
  { noremap = true, silent = true })

