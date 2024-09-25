return {
  "oflisback/obsidian-bridge.nvim",
  event = {
    "BufReadPre /Users/michael/Documents/Obsidian Vault/*.md",
    "BufNewFile /Users/michael/Documents/Obsidian Vault/*.md",
  },
  lazy = true,
  opts = {
        obsidian_server_address = "http://127.0.0.1:27123",
        scroll_sync = false -- See "Sync of buffer scrolling" section below

  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  }
}
