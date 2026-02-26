---@type LazySpec
return {
  {
    "adam12/ruby-lsp.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    ft = { "ruby", "eruby" },
    config = true,
    opts = {
      lspconfig = {
        on_attach = function(client, bufnr)
          -- Enable formatting capabilities
          client.server_capabilities.documentFormattingProvider = true

          -- Add format keybinding
          vim.keymap.set("n", "<Leader>lf", function()
            vim.lsp.buf.format()
          end, { buffer = bufnr, desc = "Format buffer" })

          -- Format on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end,
        init_options = {
          formatter = "rubocop",
          linters = { "rubocop" },
        },
      },
    },
  },
}
