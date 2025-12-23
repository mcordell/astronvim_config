return {
  "obsidian-nvim/obsidian.nvim",
  version = "3.14.7", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "main",
        path = "~/Documents/Obsidian Vault/",
      },
    },
  },
  config = function(_, opts)
    vim.wo.conceallevel = 2
    require("obsidian").setup(opts)
  end,
}
