return {
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        },
        config = function()
            require("telescope").load_extension("lazygit")
        end,
    },

    {
        'sindrets/diffview.nvim',
        event = "VeryLazy"
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function ()
            require('gitsigns').setup {
                current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                        virt_text = true,
                        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                        delay = 100,
                        ignore_whitespace = false,
                        virt_text_priority = 100,
                        use_focus = true,
                    },
                signcolumn = false,  -- Toggle with `:Gitsigns toggle_signs`
                current_line_blame_formatter = '[<abbrev_sha>] <author> (<author_time:%R>) - <summary>',
            }
        end
    }
            
}
