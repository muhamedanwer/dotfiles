local dap = require("dap")
local dapui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")

dapui.setup()
dap_virtual_text.setup()

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.after.event_terminated["dapui_config"] = dapui.close
dap.listeners.after.event_exited["dapui_config"] = dapui.close

-- Python DAP
require("dap-python").setup(vim.fn.expand("~/.nvim-venv/bin/python"))

-- C/C++ DAP (GDB)
dap.adapters.gdb = {
  id = "gdb",
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" },
}

dap.configurations.c = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.cpp = dap.configurations.c

-- Rust DAP (uses codelldb via rustaceanvim)
-- rustaceanvim automatically configures DAP for Rust

-- Keymaps
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Conditional breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue/start debugger" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })
vim.keymap.set("n", "<leader>du", function()
  dapui.toggle()
  vim.api.nvim_echo({ { "Toggled DAP UI", "Comment" } }, true, {})
end, { desc = "Toggle DAP UI" })
vim.keymap.set("n", "<leader>de", function() dapui.eval() end, { desc = "Evaluate expression" })

-- Signs
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "✗", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })