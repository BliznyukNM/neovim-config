local dap_ok, _ = pcall(require, "dap")
if not dap_ok then
  print("nvim-dap is not available")
	return
end

local di_ok, dap_install = pcall(require, "dap-install")
if not di_ok then
  print("nvim-dap is not available")
	return
end

local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

for _, debugger in ipairs(dbg_list) do
	dap_install.config(debugger)
end

require("nvim-dap-virtual-text").setup()

vim.fn.sign_define('DapBreakpoint', {text='', texthl='Error', linehl='', numhl=''})

local M = {}

local sidebar

function M.open_sidebar_scopes()
  local widgets = require('dap.ui.widgets')
  if sidebar == nil then
    sidebar = widgets.sidebar(widgets.scopes, {width = 50})
  end
  sidebar.toggle()
end

return M
