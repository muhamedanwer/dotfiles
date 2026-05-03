local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- ── Windows ──────────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h",         "Move left")
map("n", "<C-j>", "<C-w>j",         "Move down")
map("n", "<C-k>", "<C-w>k",         "Move up")
map("n", "<C-l>", "<C-w>l",         "Move right")
map("n", "<leader>sv", "<C-w>v",    "Split vertical")
map("n", "<leader>sh", "<C-w>s",    "Split horizontal")
map("n", "<leader>sx", "<cmd>close<CR>", "Close split")

-- ── Buffers ───────────────────────────────────────────────────
map("n", "<S-l>", "<cmd>bnext<CR>",     "Next buffer")
map("n", "<S-h>", "<cmd>bprev<CR>",     "Prev buffer")
map("n", "<leader>bd", "<cmd>bdelete<CR>", "Delete buffer")

-- ── File tree ─────────────────────────────────────────────────
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", "File explorer")

-- ── Telescope ─────────────────────────────────────────────────
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>",  "Find files")
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",   "Live grep")
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>",     "Buffers")
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>",   "Help")
map("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", "Diagnostics")

-- ── LSP (set in lsp.lua on_attach, but globals here) ─────────
map("n", "<leader>lf", vim.lsp.buf.format, "Format")
map("n", "<leader>la", vim.lsp.buf.code_action, "Code action")
map("n", "<leader>lr", vim.lsp.buf.rename,      "Rename")
map("n", "gd",         vim.lsp.buf.definition,  "Go to definition")
map("n", "gr",         "<cmd>Telescope lsp_references<CR>", "References")
map("n", "K",          vim.lsp.buf.hover,        "Hover docs")
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, "Prev diagnostic")
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next diagnostic")

-- ── Python ────────────────────────────────────────────────────
map("n", "<leader>pr", "<cmd>!python3 %<CR>",        "Run Python file")
map("n", "<leader>pt", "<cmd>!pytest %<CR>",          "Run pytest")
map("n", "<leader>pv", "<cmd>!python3 -m venv .venv<CR>", "Create venv")

-- ── SQL (dadbod) ──────────────────────────────────────────────
map("n", "<leader>db", "<cmd>DBUIToggle<CR>",   "Toggle DB UI")
map("n", "<leader>dq", "<cmd>DBUIExecute<CR>",  "Execute SQL query")

-- ── Jupyter (molten) ──────────────────────────────────────────
map("n", "<leader>ji", "<cmd>MoltenInit<CR>",                       "Jupyter init kernel")
map("n", "<leader>jj", "<cmd>MoltenEvaluateLine<CR>",               "Evaluate line")
map("v", "<leader>jj", ":<C-u>MoltenEvaluateVisual<CR>",            "Evaluate selection")
map("n", "<leader>jr", "<cmd>MoltenReevaluateCell<CR>",             "Re-eval cell")
map("n", "<leader>jd", "<cmd>MoltenDelete<CR>",                     "Delete cell")
map("n", "<leader>jo", "<cmd>MoltenShowOutput<CR>",                 "Show output")
map("n", "<leader>jx", "<cmd>MoltenInterrupt<CR>",                  "Interrupt kernel")
map("n", "<leader>jk", "<cmd>MoltenKernelInfo<CR>",                 "Kernel info")

-- ── LaTeX ─────────────────────────────────────────────────────
map("n", "<leader>ll", "<cmd>VimtexCompile<CR>",   "Compile LaTeX")
map("n", "<leader>lv", "<cmd>VimtexView<CR>",      "View PDF")
map("n", "<leader>lc", "<cmd>VimtexClean<CR>",     "Clean aux files")
map("n", "<leader>le", "<cmd>VimtexErrors<CR>",    "LaTeX errors")

-- ── Markdown ──────────────────────────────────────────────────
map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", "Markdown preview")

-- ── PDF ───────────────────────────────────────────────────────
map("n", "<leader>pf", "<cmd>lua require('config.pdf').open()<CR>", "Open PDF")

-- ── AI (Avante chat) ──────────────────────────────────────────
map("n", "<leader>aa", "<cmd>AvanteAsk<CR>",    "AI ask")
map("v", "<leader>aa", "<cmd>AvanteAsk<CR>",    "AI ask (selection)")
map("n", "<leader>ac", "<cmd>AvanteChat<CR>",   "AI chat")
map("n", "<leader>ae", "<cmd>AvanteEdit<CR>",   "AI edit")

-- ── Misc ─────────────────────────────────────────────────────
map("n", "<leader>w", "<cmd>w<CR>",    "Save")
map("n", "<leader>q", "<cmd>q<CR>",   "Quit")
map("n", "<Esc>",     "<cmd>nohlsearch<CR>", "Clear search highlight")
map("n", "<leader>z", "<cmd>ZenMode<CR>", "Zen mode")
