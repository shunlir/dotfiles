local g = vim.g
local opt = vim.opt
local env = vim.env
local cmd = vim.cmd

g.mapleader = ' '

if env.COLORTERM == 'truecolor' then
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
