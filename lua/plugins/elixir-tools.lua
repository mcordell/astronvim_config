return {
  "elixir-tools/elixir-tools.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local elixir = require("elixir")
    local elixirls = require("elixir.elixirls")

    elixir.setup {
      nextls = {enable = true,
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<space>lf", ":lua vim.lsp.buf.format()<cr>", { buffer = true, noremap = true })
        end,
         init_options = {
            mix_env = "dev",
            mix_target = "host",
            experimental = {
              completions = {
                enable = true -- control if completions are enabled. defaults to false
              }
            }
          }
      },
      elixirls = {
        enable = true,
        settings = elixirls.settings {
          dialyzerEnabled = false,
          enableTestLenses = false,
        },
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
          vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
          vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
        end,
      },
      projectionist = {
        enable = true
      }
    }
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
