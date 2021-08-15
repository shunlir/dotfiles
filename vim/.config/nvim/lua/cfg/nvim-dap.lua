return function()
  local dap = require('dap')
  dap.defaults.fallback.terminal_win_cmd = 'below 5sp new'

  local dap_install = require("dap-install")
  dap_install.config("ccppr_vsc_dbg", {})
  dap_install.config("dnetcs_dbg", {})
  --[[
  dap.adapters.cppdbg = {
    type = 'executable',
    command = vim.fn.stdpath('data') .. '/dapinstall/ccppr_vsc_dbg/extension/debugAdapters/OpenDebugAD7',
  }
  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "cppdbg",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = true,
    },
    {
      name = 'Attach to gdbserver :1234',
      type = 'cppdbg',
      request = 'launch',
      MIMode = 'gdb',
      miDebuggerServerAddress = 'localhost:1234',
      miDebuggerPath = '/usr/bin/gdb',
      cwd = '${workspaceFolder}',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
    },
  }
  --]]
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
end
