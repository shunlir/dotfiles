local g = vim.g
local opt = vim.opt
local env = vim.env
local cmd = vim.cmd

g.mapleader = ' '

if env.COLORTERM == 'truecolor' or
   string.match(vim.env.TERM, '^st-.*$') or
   string.match(vim.env.TERM, '^xst-.*$') or
   string.match(vim.env.TERM, '^tmux-.*$') or
   string.match(vim.env.TERM, '^gnome-.*$') or
   string.match(vim.env.TERM, '^vte-.*$') then
  opt.termguicolors = true
end

opt.signcolumn = 'yes'
opt.ignorecase = true

g.loaded_netrwPlugin = 1
g.loaded_matchit = 1

cmd [[
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
    return ...
end

require('plugins')

local function extract_symbols(items, _result)
  local result = _result or {}
  if items == nil then return result end
  for _, item in ipairs(items) do
    local kind = require('vim.lsp.protocol').SymbolKind[item.kind] or 'Unknown'
    local sym_range = nil
    if item.location then -- Item is a SymbolInformation
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

local function current_function_callback(_, _, result, _, _)
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
      local lines = {'in'}
      table.insert(lines, '`' .. fn_name .. '`')
      local opts = {
        height = 2
      }
      require 'vim.lsp.util'.open_floating_preview(lines, 'markdown', opts)
      return
    end
  end
end

function _G.my_test()
  local params = { textDocument = require('vim.lsp.util').make_text_document_params() }
  vim.lsp.buf_request(0, 'textDocument/documentSymbol', params, current_function_callback)
end


local map = vim.api.nvim_set_keymap

local opts = { noremap=true, silent=true }
map('n', '<leader>f', '<Cmd>lua my_test()<CR>', opts)
map('x', '<leader>lf', '<Cmd>lua vim.lsp.buf.range_formatting()<cr>', opts)
