local omnisharp_bin = vim.fn.expand "$HOME/.local/share/nvim/lsp-servers/omnisharp-mono/omnisharp-mono/OmniSharp.exe"
local pid = vim.fn.getpid()

return {
  cmd = { "mono", omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
  root_markers = { '*.sln', '*.csproj', 'omnisharp.json', 'function.json' },
}
