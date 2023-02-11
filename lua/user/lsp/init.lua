local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

require "user.lsp.lsp-installer"
require "user.lsp.null-ls"

local handlers = require("user.lsp.handlers")
handlers.setup()

lspconfig.gdscript.setup {
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities
}
