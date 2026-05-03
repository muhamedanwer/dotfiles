-- lua/plugins/treesitter.lua
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy  = false,
        opts  = {
            ensure_installed = {
                "python", "sql", "lua", "markdown", "markdown_inline",
                "latex", "bash", "json", "yaml", "toml", "regex",
                "vim", "vimdoc", "query",
            },
            highlight        = { enable = true },
            indent           = { enable = true },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        event        = "BufReadPost",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config       = function()
            require("treesitter-context").setup({ max_lines = 3 })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy         = true,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
