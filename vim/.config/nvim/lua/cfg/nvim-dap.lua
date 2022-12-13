return function()
  local dap = require('dap')
  dap.defaults.fallback.terminal_win_cmd = 'below 5sp new'

  dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = vim.fn.stdpath('data') .. '/dap_debuggers/cpptools/extension/debugAdapters/OpenDebugAD7',
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
      setupCommands = {
       {
          text = '-enable-pretty-printing',
          description =  'enable pretty printing',
          ignoreFailures = false
       },
     },
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
      setupCommands = {
       {
          text = '-enable-pretty-printing',
          description =  'enable pretty printing',
          ignoreFailures = false
       },
     },
    },
  }
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
end
