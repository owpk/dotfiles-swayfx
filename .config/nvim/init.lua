-- CONFIGS
require "user.plugins"
require "user.nerdtree" -- file tree side bar
require "user.hot-reload" 
require "user.autocommands"
require "user.colorscheme"
require "user.cmp"
require "user.navic"
require "user.lsp-inlayhints"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.gitsigns"
require "user.toggleterm"
require "user.project"
require "user.impatient" -- speedup loading lua modules
require "user.indentline" -- auto tabs under code snippets
require "user.typescript"
require "user.options"
require "user.lualine"
require "user.symbol-outline" -- A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
require "user.illuminate" -- automatically highlighting other uses
require "user.dap" -- debug adapter protocol client
require "user.nvim-webdev-icons"
require "user.bfs"
require "user.dressing" -- improve the default vim.ui interfaces
require "user.fidget" -- UI for Neovim notifications and LSP progress messages.
require "user.auto-session" -- takes advantage of Neovim's existing session management capabilities to provide seamless automatic session management.
require "user.keymaps"

local registers = require("registers")

registers.setup({
  hide_only_whitespace = true,
  show_empty = true,
  trim_whitespace = true,
  window = {
    border = "rounded"
  }
})
