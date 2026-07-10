-- Productivity & Focus UI Configuration

-- Startup message
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("StartupMessage", {}),
  callback = function()
    if vim.fn.argc() == 0 and not vim.g.started_by_firenvim then
      local ascii = {
          " █████╗  ███╗   ██╗██╗ ███╗   ██╗ █████╗ ██████╗ ",
          "██╔══██╗ ████╗  ██║██║ ████╗  ██║██╔══██╗██╔══██╗",
          "███████║ ██╔██╗ ██║██║ ██╔██╗ ██║███████║██████╔╝",
          "██╔══██║ ██║╚██╗██║██║ ██║╚██╗██║██╔══██║██╔══██╗",
          "██║  ██║ ██║ ╚████║██║ ██║ ╚████║██║  ██║██║  ██║",
          "╚═╝  ╚═╝ ╚═╝  ╚═══╝╚═╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝",
          "",
          "  Neovim IDE ready • <leader>ff to find files",
      }
      vim.schedule(function()
        for _, line in ipairs(ascii) do
          vim.api.nvim_echo({ { line, "Title" } }, true, {})
        end
      end)
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", {}),
  callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 }) end,
})

-- Auto-resize splits when window resized
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("ResizeSplits", {}),
  callback = function() vim.cmd("tabdo wincmd =") end,
})

-- Remember cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("RestoreCursor", {}),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close certain filetypes with q
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("CloseWithQ", {}),
  pattern = { "help", "man", "qf", "lspinfo", "checkhealth", "neotest-summary", "neotest-output", "dbui", "tsplayground" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("TerminalSettings", {}),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
})

-- Auto-create directories when saving
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("AutoCreateDir", {}),
  callback = function(event)
    if event.match:match("^%w%w+://") then return end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Focus mode: disable distractions
local focus_mode = false
function _G.toggle_focus_mode()
  focus_mode = not focus_mode
  if focus_mode then
    vim.opt.laststatus = 0
    vim.opt.showcmd = false
    vim.opt.ruler = false
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.opt.signcolumn = "no"
    vim.opt.cursorline = false
    vim.opt.colorcolumn = ""
    vim.cmd("NvimTreeClose")
    vim.cmd("TroubleClose")
    print("Focus mode: ON")
  else
    vim.opt.laststatus = 3
    vim.opt.showcmd = true
    vim.opt.ruler = true
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.signcolumn = "yes"
    vim.opt.cursorline = true
    vim.opt.colorcolumn = "100"
    print("Focus mode: OFF")
  end
end

-- Statusline: show macro recording
vim.api.nvim_create_autocmd("RecordingEnter", {
  group = vim.api.nvim_create_augroup("MacroRecording", {}),
  callback = function()
    vim.opt.cmdheight = 1
    print("Recording @" .. vim.fn.reg_recording())
  end,
})
vim.api.nvim_create_autocmd("RecordingLeave", {
  group = vim.api.nvim_create_augroup("MacroRecordingEnd", {}),
  callback = function()
    vim.opt.cmdheight = 0
    print("Macro recording stopped")
  end,
})

-- Better command-line completion
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignorecase = true
vim.opt.wildignore = { "*.o", "*.obj", "*.pyc", "*.class", "*.jar", "*.swp", "*.zip", "*.exe", "*.dll", "*.so", "*.dylib", "node_modules", ".git", "__pycache__", "target", "build", "dist" }

-- Better diff
vim.opt.diffopt:append("linematch:60")
vim.opt.diffopt:append("algorithm:histogram")

-- Title
vim.opt.title = true
vim.opt.titlestring = "%f %m%r - nvim"

-- Session options
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- Disable startup message
vim.opt.shortmess:append("I")

-- Better completion menu
vim.opt.pumheight = 10
vim.opt.pumblend = 10

-- Spell check for text files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit", "tex" },
  callback = function() vim.opt_local.spell = true end,
})

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("TrimWhitespace", {}),
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Toggle relative numbers in insert mode
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("ToggleRelNumber", {}),
  callback = function(event)
    if vim.wo.number then
      vim.wo.relativenumber = event.event == "InsertLeave"
    end
  end,
})

-- Which-key groups (lazy-loaded)
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>f", group = "Find/Telescope" },
      { "<leader>g", group = "Git" },
      { "<leader>d", group = "Debug/DAP" },
      { "<leader>t", group = "Test/Trouble" },
      { "<leader>r", group = "Rust" },
      { "<leader>D", group = "Database" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>a", group = "AI" },
      { "<leader>x", group = "Trouble" },
      { "<leader>w", proxy = "w", desc = "Save" },
      { "<leader>q", proxy = "q", desc = "Quit" },
      { "<leader>e", proxy = "e", desc = "File explorer" },
      { "<leader>z", proxy = "z", desc = "Zen/Focus mode" },
      { "<leader>u", proxy = "u", desc = "Undotree" },
      { "<leader>v", proxy = "vs", desc = "Python venv" },
      { "<leader>m", proxy = "fm", desc = "Format" },
    })
  end,
})