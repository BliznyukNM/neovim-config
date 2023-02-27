return {
  adapters = {
    codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.expand "$HOME/.local/share/nvim/mason/packages/codelldb/codelldb",
        args = { "--port", "${port}" }
      }
    }
  },
  configurations = {
    cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
      {
        name = 'Attach to process',
        type = 'codelldb',
        request = 'attach',
        pid = require 'dap.utils'.pick_process,
        stopOnEntry = true,
        waitFor = true,
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
      },
      {
        name = "Launch Godot",
        type = "codelldb",
        request = "launch",
        cwd = '${workspaceFolder}',
        program = function()
          return vim.fn.input('Path to Godot Editor: ', vim.fn.getcwd() .. '/bin/', 'file')
        end,
        args = { "--editor", "--path",
          function()
            return vim.fn.input('Path to project: ', vim.fn.expand "$HOME/Projects/", 'file')
          end },
        stopOnEntry = false,
      },
    }
  }
}
