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
    -- add more treesitter parsers
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
        ensure_installed = {
            "bash",
            "json",
            "cpp",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "vim",
            "lua",
            "yaml",
        },
        },
    },
    {
        "mbbill/undotree",
    },
    {
        'tzachar/highlight-undo.nvim',
    },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
    -- {
    --   "nvim-treesitter/nvim-treesitter",
    --   opts = function(_, opts)
    --   -- add tsx and treesitter
    --   vim.list_extend(opts.ensure_installed, {
    --     "cpp",
    --   })
    --   end,
    -- },

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
        },
        },
    },
}
