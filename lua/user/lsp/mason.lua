local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not mason_lsp_ok then
  return
end

local lsp_ok, lsp_config = pcall(require, "lspconfig")
if not lsp_ok then
  return
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

mason_lsp.setup()

local handlers = require("user.lsp.handlers")
handlers.setup()

local opts = {
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities
}

mason_lsp.setup_handlers {
  function (server_name)
    local ok, config = pcall(require, "user.lsp.settings." .. server_name)
    if ok then
      config = vim.tbl_deep_extend("force", config, opts)
    else
      config = opts
    end
    lsp_config[server_name].setup(config)
  end
}

lsp_config.gdscript.setup(opts)
