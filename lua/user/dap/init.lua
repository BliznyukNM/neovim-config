local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  return
end

local godot_opts = require("user.dap.settings.godot")
dap.adapters = vim.tbl_deep_extend("force", godot_opts.adapters, dap.adapters)
dap.configurations = vim.tbl_deep_extend("force", godot_opts.configurations, dap.configurations)

local cpp_opts = require("user.dap.settings.cpp")
dap.adapters = vim.tbl_deep_extend("force", cpp_opts.adapters, dap.adapters)
dap.configurations = vim.tbl_deep_extend("force", cpp_opts.configurations, dap.configurations)

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
