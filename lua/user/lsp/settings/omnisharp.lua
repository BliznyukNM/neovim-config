local omnisharp_bin = vim.fn.expand "$HOME/.local/share/nvim/lsp_servers/omnisharp/omnisharp/omnisharp/OmniSharp.exe"
local pid = vim.fn.getpid()

return {
  cmd = { "mono", omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
}
