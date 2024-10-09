-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  {
    "shaunsingh/nord.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "tpope/vim-rhubarb",
    lazy = false,
  },
  {
    "tpope/vim-projectionist",
    lazy = false,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      region_check_events = "CursorMoved",
    },
    config = function(plugin, opts)
      opts["enable_autosnippets"] = true
      opts["store_selection_keys"] = "<Tab>"
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      require("luasnip.loaders.from_vscode").load {
        exclude = { "ruby", "markdown", "elixir" },
      }
      require("luasnip.loaders.from_lua").load {
        paths = { "~/.config/nvim/lua/LuaSnip/" },
      }
    end,
  },
  {
    "jlcrochet/vim-rbs",
    ft = "rbs",
  },
  {
    "IndianBoy42/tree-sitter-just",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.parsers").get_parser_configs().just = {
        install_info = {
          url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
          files = { "src/parser.c", "src/scanner.cc" },
          branch = "main",
          use_makefile = true, -- this may be necessary on MacOS (try if you see compiler errors)
        },
        maintainers = { "@IndianBoy42" },
      }
    end,
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup {
        api_key_cmd = "op read op://Personal/OpenAIAPI/credential --no-newline",
        actions_paths = { "/Users/michael/.dotfiles/astronvim_user_config/plugins/actions.json" },
      }
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "AndrewRadev/splitjoin.vim",
    event = "VeryLazy",
  },
}
