local M = {}

M.root_patterns = { ".git" }

local function extract_symbols(items, _result)
  local result = _result or {}
  if items == nil then return result end
  for _, item in ipairs(items) do
    local kind = require('vim.lsp.protocol').SymbolKind[item.kind] or 'Unknown'
    local sym_range = nil
    if item.location then  -- Item is a SymbolInformation
      sym_range = item.location.range
    elseif item.range then -- Item is a DocumentSymbol
      sym_range = item.range
    end

    if sym_range then
      sym_range.start.line = sym_range.start.line + 1
      sym_range['end'].line = sym_range['end'].line + 1
    end

    table.insert(result, {
      filename = item.location and vim.uri_to_fname(item.location.uri) or nil,
      range = sym_range,
      kind = kind,
      text = item.name,
      detail = item.detail,
      raw_item = item
    })

    if item.children then
      extract_symbols(item.children, result)
    end
  end

  return result
end

local function in_range(pos, range)
  local line = pos[1]
  local char = pos[2]
  if line < range.start.line or line > range['end'].line then return false end
  if
    line == range.start.line and char < range.start.character or
    line == range['end'].line and char > range['end'].character
  then
    return false
  end

  return true
end

local function filter(list, test)
  local result = {}
  for i, v in ipairs(list) do
    if test(i, v) then
      table.insert(result, v)
    end
  end

  return result
end

local scope_kinds = {
  Class = true,
  Function = true,
  Method = true,
  Struct = true,
  Enum = true,
  Interface = true,
  Namespace = true,
  Module = true,
}

local function current_function_callback(_, result, _, _)
  if type(result) ~= 'table' then
    return
  end

  local function_symbols = filter(extract_symbols(result),
    function(_, v)
      return scope_kinds[v.kind]
    end)

  if not function_symbols or #function_symbols == 0 then
    return
  end
  local select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
      local value_range = {
        ["start"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[1])
        },
        ["end"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[2])
        }
      }

      return require("lsp-status.util").in_range(cursor_pos, value_range)
    end
  end

  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  for i = #function_symbols, 1, -1 do
    local sym = function_symbols[i]
    if
      (sym.range and in_range(cursor_pos, sym.range))
      or (select_symbol(cursor_pos, sym.raw_item))
    then
      local fn_name = sym.text
      --[[
      if _config.kind_labels and _config.kind_labels[sym.kind] then
        fn_name = _config.kind_labels[sym.kind] .. ' ' .. fn_name
      end
      --]]
      print(fn_name)
      local lines = { sym.detail }
      table.insert(lines, '`' .. fn_name .. '`')
      local opts = {
        height = 2
      }
      require 'vim.lsp.util'.open_floating_preview(lines, 'markdown', opts)
      return
    end
  end
end

M.which_func = function()
  local params = { textDocument = require('vim.lsp.util').make_text_document_params(0) }
  vim.lsp.buf_request(0, 'textDocument/documentSymbol', params, current_function_callback)

  --[[ alternatively
  local lines = {'`' .. require("nvim-treesitter").statusline({indicator_size=120}) .. '`'}
  local opts = { height = 2 }
  require 'vim.lsp.util'.open_floating_preview(lines, 'markdown', opts)
  --]]
end

-- toggle diagnostic show/hide for all buffers
M.diagnostics_visible = true
M.diagnostics_toggle = function()
  M.diagnostics_visible = not M.diagnostics_visible
  if M.diagnostics_visible then
    vim.diagnostic.show(nil, 0)
  else
    vim.diagnostic.hide()
  end
end

function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

return M
