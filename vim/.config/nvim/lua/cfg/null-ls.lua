return function()
  local h = require("null-ls.helpers")
  require("null-ls").setup({
    on_init = function(new_client, _)
      new_client.offset_encoding = 'utf-32'
    end,
    sources = {
      require("null-ls").builtins.diagnostics.cppcheck.with({
        diagnostics_format = "#{m}",
        args = {
          "--enable=warning,style,performance,portability",
          "--template=\"{file}:{line}:{column}:{severity}:{id}: {message}\"",
          "$FILENAME",
        },
        on_output = h.diagnostics.from_pattern([[(%d+):(%d+):(%w+):(%w+): (.*)]], { "row", "col", "severity", "code", "message" }, {
          severities = {
            note = h.diagnostics.severities["information"],
            style = h.diagnostics.severities["hint"],
            performance = h.diagnostics.severities["warning"],
            portability = h.diagnostics.severities["information"],
          },
        }),
      }),
    },
  })
end
