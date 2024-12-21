-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
    -- add gruvbox
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                contrast = "medium", -- 可选："hard", "soft", "medium"
                palette_overrides = {},
                overrides = {},
                transparent_mode = false, -- 开启透明背景
            })
            vim.cmd("colorscheme gruvbox") -- 设置主题
        end,
    },

--   {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--       "williamboman/mason.nvim",
--       "williamboman/mason-lspconfig.nvim",
--       "hrsh7th/cmp-nvim-lsp",
--     },
--     config = function()
--       local lspconfig = require("lspconfig")
--       local capabilities = require("cmp_nvim_lsp").default_capabilities()

--       -- Clangd 配置
--       lspconfig.clangd.setup({
--         cmd = {
--           "clangd",
--           "--background-index", -- 后台索引以提高性能
--           "--suggest-missing-includes", -- 建议缺失的头文件
--           "--clang-tidy", -- 集成 clang-tidy
--           "--all-scopes-completion", -- 所有作用域补全
--           "--header-insertion=iwyu", -- 智能头文件插入
--         },
--         capabilities = capabilities,
--         on_attach = function(client, bufnr)
--           -- 自定义键绑定或其他初始化逻辑
--           local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--           local opts = { noremap=true, silent=true }
--           buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--           buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
--           -- 更多键绑定...
--         end,
--       })
--     end,
--   },

    -- add more treesitter parsers
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
        ensure_installed = {
            "bash",
            "html",
            "javascript",
            "json",
            "lua",
            "cpp",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "tsx",
            "typescript",
            "vim",
            "yaml",
        },
        },
    },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "cpp",
      })
      end,
    },

    {
        "HiPhish/rainbow-delimiters.nvim",
        event = "BufReadPost",
    },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
    { import = "lazyvim.plugins.extras.lang.json" },

    -- add any tools you want to have installed below
    {
        "williamboman/mason.nvim",
        opts = {
        ensure_installed = {
            "stylua",
            "shellcheck",
            "shfmt",
            "flake8",
            "clangd",
            "lazygit",
        },
        },
    },
}
