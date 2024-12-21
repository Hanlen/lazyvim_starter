return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = { enabled = false },
            diagnostics = {
                underline = false,
                update_in_insert = false,
                virtual_text = {
                spacing = 4,
                source = "if_many",
                prefix = "●",
                -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
                -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
                -- prefix = "icons",
                },
                severity_sort = true,
            },
        },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function(_, opts)
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            require'lspconfig'.clangd.setup {
                capabilities = capabilities,
                cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--inlay-hints=true", -- 启用内联提示
                "--header-insertion=never",
                "--completion-style=detailed",
                "--function-arg-placeholders",
                "--fallback-style=llvm",
                '--compile-commands-dir=' .. vim.fn.getcwd() .. '/build',
                },
                init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                clangdFileStatus = true,
                },
            }
        end
    },
    {
        "folke/trouble.nvim",
        cmd = { "Trouble" },
        opts = {
          modes = {
            lsp = {
              win = { position = "right" },
            },
          },
        },
        keys = {
          { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
          { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
          { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
          { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
          { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
          { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
          {
            "[q",
            function()
              if require("trouble").is_open() then
                require("trouble").prev({ skip_groups = true, jump = true })
              else
                local ok, err = pcall(vim.cmd.cprev)
                if not ok then
                  vim.notify(err, vim.log.levels.ERROR)
                end
              end
            end,
            desc = "Previous Trouble/Quickfix Item",
          },
          {
            "]q",
            function()
              if require("trouble").is_open() then
                require("trouble").next({ skip_groups = true, jump = true })
              else
                local ok, err = pcall(vim.cmd.cnext)
                if not ok then
                  vim.notify(err, vim.log.levels.ERROR)
                end
              end
            end,
            desc = "Next Trouble/Quickfix Item",
          },
        },
      }
}