return function()
  require("mason").setup()
  require("mason-lspconfig").setup()
  local lspconfig = require("lspconfig")

  -- vim.diagnostic.config({virtual_text = { source = true}})
  local function hack_clangd_ccls(client)
    if client.name == 'ccls' then
      client.server_capabilities.hoverProvider = false
      client.server_capabilities.completionProvider = false
      client.server_capabilities.codeActionProvider = false
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentHighlightProvider = false
      client.server_capabilities.documentLinkProvider = false
      client.server_capabilities.documentOnTypeFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      client.server_capabilities.documentSymbolProvider = false
      client.server_capabilities.renameProvider = false
      client.server_capabilities.signatureHelpProvider = false
      -- client.server_capabilities.codeLensProvider = false
      -- client.server_capabilities.foldingRangeProvider = false
    elseif client.name == 'clangd' then
      client.server_capabilities.definitionProvider = false
      client.server_capabilities.referencesProvider = false
      client.server_capabilities.declarationProvider = false
      client.server_capabilities.typeDefinitionProvider = false
      client.server_capabilities.implementationProvider = false
      client.server_capabilities.workspaceSymbolProvider = false
    end
  end

  local on_attach = function(client, bufnr)
    hack_clangd_ccls(client)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', 'gd', '<Cmd>Telescope lsp_definitions theme=get_ivy<CR>', opts)
    buf_set_keymap('n', 'gD', '<cmd>Telescope lsp_references theme=get_ivy<CR>', opts)
    buf_set_keymap('n', 'gt', '<Cmd>Telescope lsp_type_definitions theme=get_ivy<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations theme=get_ivy<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>le',
      '<cmd>lua vim.diagnostic.open_float(0, {scope="line",source="always", format=function(diag) return string.format("%s [%s]", diag.message, diag.code or (diag.user_data and diag.user_data.lsp and diag.user_data.lsp.code)) end})<CR>',
      opts)
    buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.setloclist()<CR>', opts)


    -- Set autocommands conditional on server_capabilities
    -- if client.server_capabilities.documentHighlightProvider then
    --   vim.api.nvim_exec([[
    --   augroup lsp_document_highlight
    --   autocmd! * <buffer>
    --   autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    --   autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    --   augroup END
    --   ]], false)
    -- end

    -- signiture help support
    --[[
    require "lsp_signature".on_attach {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
      hint_enable = false
    }]]
  end


  -- config that activates keymaps and enables snippet support
  local function make_opts()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    capabilities.offsetEncoding = { "utf-32" }
    return {
      -- enable snippet support
      capabilities = capabilities,
      -- map buffer local keybindings when the language server attaches
      on_attach = on_attach,
    }
  end

  local enhance_server_opts = {
    ["lua_ls"] = function(opts)
      -- Configure lua language server for neovim development
      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")
      opts.settings = {
        Lua = {
          runtime = {
            -- LuaJIT in the case of Neovim
            version = 'LuaJIT',
            path = runtime_path,
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            -- Disable the message on every startup 'Do you need to configure your work environment as xxx'
            checkThirdParty = false,
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      }
    end,

    ["clangd"] = function(opts)
      opts.filetypes = { "c", "cpp" }; -- we don't want objective-c and objective-cpp!
      -- opts.cmd = {"clangd", "--background-index", "--pch-storage=disk", "--completion-style=detailed", "--clang-tidy", "--enable-config", "--offset-encoding=utf-32"}
      opts.cmd = { "clangd", "--background-index", "--pch-storage=disk", "--completion-style=detailed", "--clang-tidy",
        "--enable-config" }
      opts.root_dir = require('lspconfig.util').root_pattern(
          '.git',
          'compile_commands.json',
          'compile_flags.txt',
          'configure.ac'
        )
    end,

    ["ccls"] = function(opts)
      opts.cmd = { '/opt/ccls/bin/ccls' }
      opts.filetypes = { "c", "cpp" } -- we don't want objective-c and objective-cpp!
      opts.init_options = {
        cache = {
          directory = vim.fn.expand("~/.cache/ccls")
        },
        clang = {
          resourceDir = '/opt/ccls/clang-resource'
        },
      }
    end,
  }

  local servers = { 'lua_ls', 'clangd', 'ccls' }
  for _, server in ipairs(servers) do
    local opts = make_opts()
    -- language specific config
    if enhance_server_opts[server] then
      enhance_server_opts[server](opts)
    end
    if server == "clangd" then
      require("clangd_extensions").setup { server = opts }
    else
      lspconfig[server].setup(opts)
    end
  end
end
