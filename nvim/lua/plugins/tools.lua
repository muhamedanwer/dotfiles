return {

  -- ── Telescope ─────────────────────────────────────────────
  {
    "nvim-telescope/telescope.nvim",
    cmd  = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-dap.nvim",
      "ahmedkhalf/project.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions   = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix  = "  ",
          selection_caret = " ",
          entry_prefix   = "  ",
          border         = true,
          borderchars    = { "─","│","─","│","╭","╮","╯","╰" },
          layout_config  = { horizontal = { preview_width = 0.55 } },
          mappings = {
            i = {
              ["<C-j>"]    = actions.move_selection_next,
              ["<C-k>"]    = actions.move_selection_previous,
              ["<C-q>"]    = actions.smart_send_to_qflist + actions.open_qflist,
              ["<Esc>"]    = actions.close,
            },
          },
          file_ignore_patterns = {
            "node_modules", ".git/", "__pycache__", "*.pyc",
            ".venv/", "dist/", "build/", "%.ipynb_checkpoints",
          },
        },
        pickers = {
          find_files   = { hidden = true },
          live_grep    = { additional_args = { "--hidden" } },
        },
        extensions = {
          fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true },
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("projects")

      -- Projects
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "pyproject.toml", "setup.py", "requirements.txt", "Makefile" },
      })
    end,
  },

  -- ── PDF Reader (open PDF in split, text extraction) ───────
  -- Uses pdftotext under the hood; install: sudo apt install poppler-utils
  {
    "theprimeagen/harpoon",   -- not PDF but useful; PDF below:
    enabled = false,
  },

  -- PDF via shell (no plugin needed — keymap defined in keymaps.lua)
  -- <leader>pf  →  opens PDF with system viewer (zathura/evince)
  -- For inline reading, we convert PDF → text with pdftotext:
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
    config = function()
      -- This is already a dep, but we attach the PDF helper here
      -- Accessible via require("config.pdf")
    end,
  },

  -- ── DAP (Python debugger) ─────────────────────────────────
  {
    "mfussenegger/nvim-dap",
    ft   = "python",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      { "rcarriga/nvim-dap-ui", dependencies = "nvim-neotest/nvim-nio" },
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap     = require("dap")
      local dapui   = require("dapui")
      local dappy   = require("dap-python")

      -- Use venv python if available
      local python = vim.fn.exepath("python3")
      if vim.fn.filereadable(".venv/bin/python") == 1 then
        python = ".venv/bin/python"
      end
      dappy.setup(python)

      dapui.setup({
        layouts = {
          { elements = { "scopes","breakpoints","stacks","watches" }, size = 40, position = "left" },
          { elements = { "repl","console" }, size = 12, position = "bottom" },
        },
      })

      require("nvim-dap-virtual-text").setup({ commented = true })

      -- Auto open/close dap-ui
      dap.listeners.after.event_initialized["dapui_config"]  = dapui.open
      dap.listeners.before.event_terminated["dapui_config"]  = dapui.close
      dap.listeners.before.event_exited["dapui_config"]      = dapui.close

      -- Keymaps
      local m = function(l, r, d) vim.keymap.set("n", l, r, { desc = d }) end
      m("<F5>",       dap.continue,          "Debug: continue")
      m("<F10>",      dap.step_over,         "Debug: step over")
      m("<F11>",      dap.step_into,         "Debug: step into")
      m("<F12>",      dap.step_out,          "Debug: step out")
      m("<leader>db", dap.toggle_breakpoint, "Toggle breakpoint")
      m("<leader>dB", function() dap.set_breakpoint(vim.fn.input("Condition: ")) end, "Conditional breakpoint")
      m("<leader>du", dapui.toggle,          "Toggle DAP UI")
    end,
  },

  -- ── Git UI ────────────────────────────────────────────────
  {
    "kdheepak/lazygit.nvim",
    cmd  = "LazyGit",
    keys = { { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" } },
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- ── Auto pairs ────────────────────────────────────────────
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({ check_ts = true })
      -- Connect to cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- ── Comments ─────────────────────────────────────────────
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = function() require("Comment").setup() end,
  },

  -- ── Todo comments ─────────────────────────────────────────
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
      vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find TODOs" })
    end,
  },

  -- ── Surround ─────────────────────────────────────────────
  {
    "kylechui/nvim-surround",
    event = "BufReadPost",
    config = function() require("nvim-surround").setup() end,
  },

  -- ── Better search/replace ────────────────────────────────
  {
    "nvim-pack/nvim-spectre",
    cmd  = "Spectre",
    keys = { { "<leader>fs", "<cmd>Spectre<CR>", desc = "Search & replace" } },
  },

}
