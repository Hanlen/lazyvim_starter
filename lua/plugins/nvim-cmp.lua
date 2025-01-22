return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- Use LuaSnip for snippet expansion
                end,
            },
            mapping = cmp.mapping.preset.insert({
                -- Use <Tab> to navigate completion menu and jump between snippet placeholders
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item() -- Navigate completion menu
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump() -- Jump to next snippet placeholder
                    else
                        fallback() -- Fallback to default <Tab> behavior
                    end
                end, { "i", "s" }), -- i - insert mode; s - select mode

                -- Use <S-Tab> to navigate backward in completion menu and snippet placeholders
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item() -- Navigate backward in completion menu
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1) -- Jump to previous snippet placeholder
                    else
                        fallback() -- Fallback to default <S-Tab> behavior
                    end
                end, { "i", "s" }),

                -- Confirm completion
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- Use LuaSnip for snippets
                { name = "buffer" },
                { name = "path" },
            }),
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
                        end,
                    },
                },
            },
        })

        -- : 命令行模式中使用 path 和 cmdline 源
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
