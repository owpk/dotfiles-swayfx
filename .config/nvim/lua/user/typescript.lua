attach = require("user.lsp.handlers").on_attach

require("lspconfig").tsserver.setup {
    on_attach = attach
}
