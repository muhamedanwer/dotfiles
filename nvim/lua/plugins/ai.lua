return {

  -- ── Codeium — Free AI inline autocomplete ─────────────────
  -- Sign up free at codeium.com, then run :Codeium Auth
  {
    "Exafunction/codeium.vim",
    event = "InsertEnter",
    config = function()
      vim.g.codeium_disable_bindings = 1  -- We control bindings
      vim.keymap.set("i", "<C-g>",     function() return vim.fn["codeium#Accept"]()   end, { expr = true, desc = "AI accept" })
      vim.keymap.set("i", "<C-;>",     function() return vim.fn["codeium#CycleCompletions"](1)  end, { expr = true })
      vim.keymap.set("i", "<C-,>",     function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
      vim.keymap.set("i", "<C-x>",     function() return vim.fn["codeium#Clear"]()    end, { expr = true })
      -- Link Codeium to cmp source
      vim.api.nvim_create_autocmd("User", {
        pattern  = "CodeiumEnabled",
        callback = function()
          require("cmp").setup({ sources = require("cmp").config.sources({
            { name = "codeium", priority = 1000 },
          }) })
        end,
      })
    end,
  },

  -- ── Avante — AI chat / edit panel (like Cursor) ───────────
  -- Requires: ANTHROPIC_API_KEY or OPENAI_API_KEY env var
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "Avante" } },
    },
    config = function()
      require("avante").setup({
        provider = "claude",           -- or "openai" / "gemini"
        providers = {
          claude = {
            endpoint = "https://api.anthropic.com",
            model    = "claude-sonnet-4-5",
            extra_request_body = {
              temperature = 0,
              max_tokens = 4096,
            },
          },
        },
        -- Matte-black panel style
        windows = {
          position = "right",
          width    = 35,
          sidebar_header = { rounded = true },
        },
        highlights = {
          diff = {
            current  = "DiffText",
            incoming = "DiffAdd",
          },
        },
        hints = { enabled = true },
        mappings = {
          ask      = "<leader>aa",
          edit     = "<leader>ae",
          refresh  = "<leader>aR",
          diff = {
            ours    = "co",
            theirs  = "ct",
            both    = "cb",
            next    = "]x",
            prev    = "[x",
          },
        },
      })
    end,
  },

}
