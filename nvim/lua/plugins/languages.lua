return {



    -- ── Python ───────────────────────────────────────────────
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
        cmd          = "VenvSelect",
        keys         = {
            { "<leader>pv", "<cmd>VenvSelect<CR>",       desc = "Select venv" },
            { "<leader>pc", "<cmd>VenvSelectCached<CR>", desc = "Use cached venv" },
        },
        config       = function()
            require("venv-selector").setup({
                auto_refresh         = true,
                search_venv_managers = true,
                search_workspace     = true,
                search               = true,
            })
        end,
    },

    -- Python REPL
    {
        "Vigemus/iron.nvim",
        ft     = "python",
        keys   = {
            { "<leader>rs", "<cmd>IronRepl<CR>",    desc = "Open REPL" },
            { "<leader>rr", "<cmd>IronRestart<CR>", desc = "Restart REPL" },
            { "<leader>rf", "<cmd>IronFocus<CR>",   desc = "Focus REPL" },
            { "<leader>rh", "<cmd>IronHide<CR>",    desc = "Hide REPL" },
        },
        config = function()
            require("iron.core").setup({
                config = {
                    repl_definition = {
                        python = {
                            command    = { "ipython", "--no-autoindent" },
                            format     = require("iron.fts.python").format,
                            block_devs = true,
                        },
                    },
                    repl_open_cmd = require("iron.view").split.vertical.botright("40%"),
                },
                keymaps = {
                    send_motion = "<leader>rc",
                    visual_send = "<leader>rc",
                    send_file   = "<leader>rF",
                    send_line   = "<leader>rl",
                    cr          = "<leader>r<CR>",
                    interrupt   = "<leader>r<space>",
                    exit        = "<leader>rq",
                    clear       = "<leader>rx",
                },
            })
        end,
    },

    -- ── SQL ───────────────────────────────────────────────────
    {
        "tpope/vim-dadbod",
        ft  = { "sql", "mysql", "plsql" },
        cmd = "DB",
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = "tpope/vim-dadbod",
        cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
        keys = {
            { "<leader>db", "<cmd>DBUIToggle<CR>",        desc = "DB UI" },
            { "<leader>da", "<cmd>DBUIAddConnection<CR>", desc = "Add DB connection" },
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts             = 1
            vim.g.db_ui_show_database_icon         = 1
            vim.g.db_ui_force_echo_notifications   = 1
            vim.g.db_ui_win_position               = "left"
            vim.g.db_ui_winwidth                   = 35
            vim.g.db_ui_save_location              = vim.fn.stdpath("data") .. "/db_ui"
            -- Auto-format SQL on save
            vim.g.db_ui_auto_execute_table_helpers = 1
        end,
    },

    -- SQL formatter
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    python = { "ruff_fix", "ruff_format" }, -- ruff is lightning fast
                    sql    = { "sqlfmt" },
                    lua    = { "stylua" },
                    sh     = { "shfmt" },
                },
                format_on_save = {
                    timeout_ms = 2000,
                    lsp_fallback = true,
                },
            })
            vim.keymap.set({ "n", "v" }, "<leader>cf", function()
                require("conform").format({ async = true, lsp_fallback = true })
            end, { desc = "Format file" })
        end,
    },

    -- ── LaTeX ─────────────────────────────────────────────────
    {
        "lervag/vimtex",
        ft   = { "tex", "latex" },
        init = function()
            vim.g.vimtex_view_method      = "zathura" -- PDF viewer (zathura on Linux, skim on macOS)
            vim.g.vimtex_compiler_method  = "latexmk"
            vim.g.vimtex_compiler_latexmk = {
                options = {
                    "-pdf",
                    "-shell-escape",
                    "-verbose",
                    "-file-line-error",
                    "-synctex=1",
                    "-interaction=nonstopmode",
                },
            }
            vim.g.vimtex_quickfix_mode    = 0 -- use Trouble instead
            vim.g.vimtex_syntax_enabled   = 1
            vim.g.tex_flavor              = "latex"
        end,
    },

    -- LaTeX math previewer (inline)
    {
        "jbyuki/nabla.nvim",
        ft   = { "tex", "latex", "markdown" },
        keys = {
            { "<leader>lp", function() require("nabla").popup() end,       desc = "Preview math" },
            { "<leader>lt", function() require("nabla").toggle_virt() end, desc = "Toggle math inline" },
        },
    },

    -- ── Markdown ──────────────────────────────────────────────
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft           = { "markdown", "Avante" },
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        config       = function()
            require("render-markdown").setup({
                -- v8+ API: heading (singular), not headings
                heading    = {
                    icons = { "# ", "## ", "### ", "#### " },
                },
                code       = { enabled = true, sign = false, width = "block", border = "thin" },
                dash       = { enabled = true },
                bullet     = { enabled = true },
                checkbox   = { enabled = true },
                -- v8+ API: pipe_table (not table)
                pipe_table = { enabled = true, style = "full" },
                -- Disable parsers we haven't installed to clear warnings
                html       = { enabled = false },
                latex      = { enabled = false },
                -- callout is now 'quote' in v8+
                quote      = { enabled = true },
            })
        end,
    },
    -- Markdown browser preview
    {
        "iamcco/markdown-preview.nvim",
        ft    = "markdown",
        build = function() vim.fn["mkdp#util#install"]() end,
        init  = function()
            vim.g.mkdp_auto_close      = 0
            vim.g.mkdp_theme           = "dark"
            vim.g.mkdp_preview_options = { mkit = {}, katex = {}, disable_sync_scroll = 0 }
        end,
    },

    -- ── Git ───────────────────────────────────────────────────
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPost",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = "▎" },
                    change       = { text = "▎" },
                    delete       = { text = "" },
                    topdelete    = { text = "" },
                    changedelete = { text = "▎" },
                    untracked    = { text = "▎" },
                },
                on_attach = function(buf)
                    local gs = package.loaded.gitsigns
                    local m  = function(l, r, d) vim.keymap.set("n", l, r, { buffer = buf, desc = d }) end
                    m("]h", gs.next_hunk, "Next hunk")
                    m("[h", gs.prev_hunk, "Prev hunk")
                    m("<leader>hs", gs.stage_hunk, "Stage hunk")
                    m("<leader>hr", gs.reset_hunk, "Reset hunk")
                    m("<leader>hb", gs.blame_line, "Blame line")
                    m("<leader>hp", gs.preview_hunk, "Preview hunk")
                    m("<leader>hd", gs.diffthis, "Diff this")
                end,
            })
        end,
    },

}
