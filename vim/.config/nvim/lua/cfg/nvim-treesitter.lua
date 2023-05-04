return function()
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "css",
      "go",
      "gomod",
      "html",
      "javascript",
      "json",
      "latex",
      "lua",
      "luadoc",
      "make",
      "markdown",
      "markdown_inline",
      "python",
      "rust",
      "typescript",
      "vimdoc",
      "yaml",
    }, -- A list of parser names, or "all"
    highlight = {
      enable = true,
      disable = {},
      additional_vim_regex_highlighting = false,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ia"] = "@parameter.inner",
          ["aa"] = "@parameter.outer",
        },
      },
      lsp_interop = {
        enable = true,
        border = 'none',
        peek_definition_code = {
          ["gk"] = "@function.outer",
          ["gK"] = "@class.outer",
        },
      },
    },
    matchup = {
      enable = true,
      disable = {},
    }
  }
end
