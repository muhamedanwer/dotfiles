return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",      -- Go
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")

      -- Python (debugpy)
      dap.adapters.python = {
        type = "executable",
        command = "python3",
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function() return "python3" end,
        },
      }

      -- C/C++ (codelldb)
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }
      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp

      -- Rust (codelldb)
      dap.configurations.rust = dap.configurations.cpp

      -- Install debugpy via mason if not present
      require("mason-nvim-dap").setup({
        ensure_installed = { "python", "codelldb" },
        automatic_installation = true,
      })
    end,
  },
  -- Helper to install DAP adapters via mason
  { "jay-babu/mason-nvim-dap.nvim", dependencies = { "williamboman/mason.nvim" } },
}
