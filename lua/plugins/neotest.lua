return {
  "nvim-neotest/neotest",
  event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "jfpedroza/neotest-elixir",
    {
      "cpb/neotest-rspec",
      branch = "cpb/update-dap-strategy",
    },
  },
  config = function()
    require("neotest").setup {
      adapters = {
        require "neotest-elixir",
        require "neotest-rspec",
      },
      status = { virtual_text = true },
      output = { enabled = true, open_on_run = true },
      quickfix = {
        enabled = true,
        open = function() vim.cmd "copen" end,
      },
    }

    -- Optionally map a key to open quickfix for test results
    vim.api.nvim_set_keymap(
      "n",
      "<leader>tq",
      "<cmd>lua require('neotest.consumers.quickfix').open()<CR>",
      { noremap = true, silent = true }
    )
  end,
}
