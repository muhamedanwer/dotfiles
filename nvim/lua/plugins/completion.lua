return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "kristijanhusak/vim-dadbod-completion",   -- SQL
      "kdheepak/cmp-latex-symbols",             -- LaTeX symbols
      -- Snippets
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp    = require("cmp")
      local luasnip = require("luasnip")

      -- Load VSCode-style snippets (Python, SQL, etc.)
      require("luasnip.loaders.from_vscode").lazy_load()

      local kind_icons = {
        Text          = "󰉿",  Method       = "󰆧",  Function     = "󰊕",
        Constructor   = "",  Field        = "󰜢",  Variable     = "󰀫",
        Class         = "󰠱",  Interface    = "",  Module       = "",
        Property      = "󰜢",  Unit         = "󰑭",  Value        = "󰎠",
        Enum          = "",  Keyword      = "󰌋",  Snippet      = "",
        Color         = "󰏘",  File         = "󰈙",  Reference    = "󰈇",
        Folder        = "󰉋",  EnumMember   = "",  Constant     = "󰏿",
        Struct        = "󰙅",  Event        = "",  Operator     = "󰆕",
        TypeParameter = "",  Codeium      = "",
      }

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        window = {
          completion    = cmp.config.window.bordered({ border = "rounded", winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel" }),
          documentation = cmp.config.window.bordered({ border = "rounded" }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]     = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]     = cmp.mapping.abort(),
          ["<CR>"]      = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "codeium",                   priority = 1000 },  -- AI first
          { name = "nvim_lsp",                  priority = 900  },
          { name = "nvim_lsp_signature_help",   priority = 800  },
          { name = "luasnip",                   priority = 750  },
          { name = "vim-dadbod-completion",     priority = 700  },
          { name = "latex_symbols",             priority = 700  },
          { name = "path",                      priority = 500  },
          { name = "buffer",                    priority = 300, keyword_length = 3 },
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            item.kind = string.format("%s ", kind_icons[item.kind] or "?")
            item.menu = ({
              codeium                 = "[AI]",
              nvim_lsp                = "[LSP]",
              luasnip                 = "[Snip]",
              ["vim-dadbod-completion"] = "[SQL]",
              latex_symbols           = "[LaTeX]",
              buffer                  = "[Buf]",
              path                    = "[Path]",
            })[entry.source.name] or ""
            return item
          end,
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
          },
        },
        ghost_text = true,  -- inline AI preview (moved out of experimental in nvim-cmp v0.2)
      })

      -- Cmdline completion
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
    end,
  },
}
