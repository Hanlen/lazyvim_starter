return {
    -- 代码补全插件
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-cmdline",
        "hrsh7th/vim-vsnip",
        "hrsh7th/cmp-path",
        'hrsh7th/cmp-nvim-lsp',
        "hrsh7th/cmp-buffer"
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
