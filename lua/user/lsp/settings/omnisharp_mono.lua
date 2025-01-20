local omnisharp_bin = vim.fn.expand "$HOME/.local/share/nvim/lsp-servers/omnisharp-mono/omnisharp-mono/OmniSharp.exe"
local pid = vim.fn.getpid()

local util = require 'lspconfig.util'

return {
  cmd = { "mono", omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
  use_mono = true,

  root_dir = util.root_pattern('*.sln', '*.csproj', 'omnisharp.json', 'function.json'),

  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
    ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
    ["textDocument/references"] = require('omnisharp_extended').references_handler,
    ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
  },
}
