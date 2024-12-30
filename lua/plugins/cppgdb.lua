return {
    {
        'rcarriga/nvim-dap-ui',
        event = "VeryLazy",
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio'
        },
        opts = {},
      
        config = function()
          local dap, dapui = require 'dap', require 'dapui'
          dap.listeners.before.attach.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.launch.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
          end
          dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
          end
          dapui.setup({
            mappings = {
                -- Use a table to apply multiple mappings
                expand = { "<CR>" },
                open = {"o", "<2-LeftMouse>" },
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            layouts = {
                    -- Changing the layout order will give more space to the first element
                    {
                        -- You can change the order of elements in the sidebar
                        elements = {
                            -- { id = "scopes", size = 0.25, },
                            { id = 'stacks', size = 0.50 },
                            { id = 'breakpoints', size = 0.25 },
                            --{ id = 'watches', size = 0.25 },
                        },
                        size = 42,
                        position = 'left', -- Can be "left" or "right"
                    },
                    {
                        elements = {
                            { id = 'repl', size = 0.60 },
                            { id = 'console', size = 0.40 },
                        },
                        size = 8,
                        position = 'bottom', -- Can be "bottom" or "top"
                    },
                },
                controls = {
                        icons = {
                            pause = '',
                            play = '',
                            step_over = '',
                            step_into = '',
                            step_out = '',
                            step_back = '',
                            run_last = '',
                            terminate = '',
                            disconnect = '',
                        },
                 },
            })
        end,
    },
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        keys = {},
        config = function()
            local dap = require("dap")
            dap.adapters.gdb = {
                id = 'gdb',
                type = 'executable',
                command = '/usr/bin/gdb',
                name = 'gdb',
                args = {'-i','dap'},
            }
            -- dap.adapters.cppdbg = {
            --     id = 'gdb',
            --     type = 'executable',
            --     command = '/home/hanlen/.vscode/extensions/ms-vscode.cpptools-1.23.2-linux-x64/debugAdapters/bin/OpenDebugAD7',
            --     name = 'cppdbg',
            --     options = {
            --         detached = false,
            --     },
            -- }
           
            --mapping = require("config.keymaps").mapDAP()
            vim.api.nvim_set_hl(0, "red",   { fg = "#ff0000" }) 
            vim.api.nvim_set_hl(0, "green",  { fg = "#9ece6a" }) 
            vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" }) 
            vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" }) 

            vim.fn.sign_define('DapBreakpoint',          { text='󰯰', texthl='orange',   linehl='DapBreakpoint', numhl='DapBreakpoint' })
            vim.fn.sign_define('DapBreakpointCondition', { text='󰯳', texthl='orange',   linehl='DapBreakpoint', numhl='DapBreakpoint' })
            vim.fn.sign_define('DapBreakpointRejected',  { text='󰍷', texthl='red', linehl='DapBreakpoint', numhl='DapBreakpoint' })
            vim.fn.sign_define('DapStopped',             { text='', texthl='yellow',  linehl='DapBreakpoint', numhl='DapBreakpoint' })
            vim.fn.sign_define('DapLogPoint',            { text='', texthl='green', linehl='DapBreakpoint', numhl='DapBreakpoint' })
        end,
    },
}
