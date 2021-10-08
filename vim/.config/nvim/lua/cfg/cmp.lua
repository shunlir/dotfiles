return function()
  vim.o.pumheight = 20
  local cmp = require'cmp'
  local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
  end
  local has_words_before = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    return not vim.api.nvim_get_current_line():sub(1, cursor[2]):match('^%s$')
  end
  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-/>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n', true)
        elseif has_words_before() and vim.fn['vsnip#available']() == 1 then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '', true)
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function()
        if vim.fn.pumvisible() == 1 then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n', true)
        elseif vim.fn['vsnip#jumpable'](-1) == 1 then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-jump-prev)', true, true, true), '', true)
        end
      end, { 'i', 's' }),
      },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'calc' },
      { name = 'vsnip' },
    },
    formatting = {
      format = function(entry, vim_item)
        -- fancy icons and a name of kind
        local lspkind_icons = {
          Text = "",
          Method = "",
          Function = "",
          Constructor = "",
          Field = "ﰠ",
          Variable = "",
          Class = "ﴯ",
          Interface = "",
          Module = "",
          Property = "ﰠ",
          Unit = "塞",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "פּ",
          Event = "",
          Operator = "",
          TypeParameter = ""
        }
        vim_item.kind = lspkind_icons[vim_item.kind] .. " " .. vim_item.kind

        -- set a name for each source
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[Latex]",
        })[entry.source.name]
        return vim_item
      end,
    },
  }
  -- autopairs <CR> mapping
  require("nvim-autopairs.completion.cmp").setup({
    map_cr = true, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` after select function or method item
    auto_select = true -- automatically select the first item
  })
end
