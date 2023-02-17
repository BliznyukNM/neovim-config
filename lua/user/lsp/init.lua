local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

require "user.lsp.mason"
require "user.lsp.null-ls"

local handlers = require("user.lsp.handlers")
handlers.setup()


local opts = {
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities
}

lspconfig.gdscript.setup(opts)
lspconfig.lua_ls.setup(opts)
lspconfig.clangd.setup(opts)
