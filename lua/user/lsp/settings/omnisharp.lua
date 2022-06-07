local omnisharp_bin = vim.fn.expand "$HOME/.local/share/nvim/lsp_servers/omnisharp/omnisharp/OmniSharp"
local pid = vim.fn.getpid()

return {
  cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
  use_mono = true
}
