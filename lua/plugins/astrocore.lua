-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      filetypestruff = {
        {
          event = "BufEnter",
          pattern = "*.md",
          command = "setlocal wrap",
        },
      },
    },
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map
        -- mappings seen under group name "Buffer"
        ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
        ["<Leader>ft"] = { "<cmd>Other test<cr>", desc = "find test" },
        ["<Leader>fa"] = { "<cmd>Other<cr>", desc = "find alternate" },
        ["<Leader>fv"] = {
          function()
            require("telescope.builtin").find_files {
              prompt_title = "Config Files",
              cwd = vim.fn.stdpath "config",
              follow = true,
            }
          end,
          desc = "Find AstroNvim config files",
        },

        [",a"] = {
          function() require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/lua/user/LuaSnip/" } end,
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        ["<Leader>fs"] = { ":w!<cr>", desc = "Save File" },
        ["<Leader>gc"] = { ":Git commit<cr>", desc = "commit" },
        [",tt"] = {
          function() require("neotest").run.run(vim.fn.expand "%") end,
          desc = "test file",
        },
        [",s"] = {
          function() require("neotest").run.run() end,
          desc = "test nearest",
        },
        [",l"] = {
          function() require("neotest").run.run_last() end,
          desc = "test last",
        },
        [",td"] = {
          function() require("neotest").run.run { strategy = "dap" } end,
          desc = "test debug",
        },
        [",to"] = {

          function() require("neotest").output.open { enter = true } end,
          desc = "test output",
        },

        [",ts"] = {
          function() require("neotest").output_panel.toggle() end,
          desc = "test output",
        },
        [",of"] = {
          ":ObsidianQuickSwitch<CR>",
          desc = "obsidian quick switch",
        },
        [",,"] = { ":b#<cr>", desc = "last buffer" },
      },
      v = {
        ["<leader>pe"] = {
          function() require("chatgpt").edit_with_instructions() end,
          desc = "Edit with instructions",
        },
      },

      -- setting a mapping to false will disable it
      -- ["<C-S>"] = false,
    },
  },
}
