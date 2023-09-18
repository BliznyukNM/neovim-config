local ok, dap = pcall(require, "dap")
if not ok then
  return
end

local godot_opts = require("user.dap.settings.godot")
dap.adapters = vim.tbl_deep_extend("force", godot_opts.adapters, dap.adapters)
dap.configurations = vim.tbl_deep_extend("force", godot_opts.configurations, dap.configurations)

local cpp_opts = require("user.dap.settings.cpp")
dap.adapters = vim.tbl_deep_extend("force", cpp_opts.adapters, dap.adapters)
dap.configurations = vim.tbl_deep_extend("force", cpp_opts.configurations, dap.configurations)

require("nvim-dap-virtual-text").setup()

ok, dapui = pcall(require, "dapui")
if ok then
  dapui.setup()

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end


vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'Error', linehl = '', numhl = '' })

local M = {}

local sidebar

function M.open_sidebar_scopes()
  local widgets = require('dap.ui.widgets')
  if sidebar == nil then
    sidebar = widgets.sidebar(widgets.scopes, { width = 50 })
  end
  sidebar.toggle()
end

return M
