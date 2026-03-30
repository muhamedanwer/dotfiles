-- Two options: Codeium (simplest, free, no key) OR local Ollama.
-- Both are free. Choose one. By default we enable Codeium.
return {
  -- OPTION 1: Codeium (free, no API key, works out of box)
  {
    "Exafunction/codeium.nvim",
    lazy = false, -- load immediately
    config = function()
      require("codeium").setup({})

      -- More ergonomic keymaps:
      -- <Tab> to accept the current suggestion
      -- <M-n> (Alt+n) to cycle to next suggestion
      -- <M-p> (Alt+p) to cycle to previous suggestion
      vim.keymap.set("i", "<Tab>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })

      vim.keymap.set("i", "<M-n>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })

      vim.keymap.set("i", "<M-p>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })

      -- Optional: manually trigger completion with <C-g>
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Complete"]()
      end, { expr = true })
    end,
  },

  -- OPTION 2: Local LLM via Ollama + gen.nvim (uncomment if you prefer local)
  -- Requires: install ollama, pull a model (e.g., codellama:7b)
  -- {
  --   "David-Kunz/gen.nvim",
  --   lazy = false,
  --   config = function()
  --     local gen = require("gen")
  --     gen.setup({
  --       model = "codellama:7b",   -- or "deepseek-coder:6.7b"
  --       host = "localhost:11434",
  --       display_mode = "split",
  --     })
  --     vim.keymap.set("n", "<leader>a", ":Gen<CR>")
  --   end,
  -- },
}
