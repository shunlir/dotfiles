return function()
  return
  require('lualine').setup({
    options = {
      icons_enabled = false,
      theme = 'jellybeans',
      component_separators = {'', ''},
      section_separators = {'', ''},
    },
    sections = {
      lualine_a = {
        {
          'filename',
          path = 1
        }
      },
      lualine_b = {
        'branch',
        'diff',
      },
      lualine_c = {
        {
          'diagnostics',
          sources = {'nvim_diagnostic'}
        }
      },
      lualine_x = {},
      lualine_y = {'encoding', 'fileformat', 'filetype'},
      lualine_z = {'location'}
    },
  })
end
