return {
    -- 代码补全插件
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",  -- LSP 源
        "hrsh7th/cmp-buffer",    -- 缓冲区补全
        "hrsh7th/cmp-path",      -- 路径补全
        "hrsh7th/cmp-cmdline",   -- 命令行补全
        "L3MON4D3/LuaSnip",      -- Snippet 引擎
        "saadparwaiz1/cmp_luasnip", -- Snippet 源
    },
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            -- 指定 snippet 引擎
            experimental = {
                ghost_text = false, --隐藏编辑时默认补全的内容,否则影响可读性 
            },
            snippet = {
                expand = function(args)
                -- For `vsnip` users.
                vim.fn["vsnip#anonymous"](args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                    ['<tab>'] = cmp.mapping(function(fallback)
                        -- Hint: if the completion menu is visible select next one
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }), -- i - insert mode; s - select mode
                    ['<CR>'] = cmp.mapping.confirm { select = true },
                }),
            -- 补全源
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                -- For vsnip users.
                { name = "vsnip" },
            }, { { name = "buffer" }, { name = "path" } }),
        })

        -- / 查找模式使用 buffer 源
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                {
                    name = "buffer", 
                    option = {
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end
                    }
                }
            },
        })

        -- : 命令行模式中使用 path 和 cmdline 源.
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })
    end,
}
