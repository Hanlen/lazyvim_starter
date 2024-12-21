-- Use the `dependencies` key to specify the dependencies of a particular plugin

return  { -- Fuzzy Finder (files, lsp, etc)
    -- 模糊查找
        -- 快速查找文件、缓冲区内容、命令、键位等。
        -- 支持模糊匹配，通过部分关键字快速定位目标。
        -- 文件搜索
    -- 搜索项目中的文件。
        -- 集成工具（如 ripgrep 和 fd）可快速检索内容。
        -- 代码导航
    -- 搜索 LSP 提供的符号（如函数、变量等）。
        -- 跳转到定义、引用等。
        -- 插件集成
    -- 与其他插件（如 nvim-lspconfig、nvim-treesitter、neogit 等）无缝集成，扩展功能。
    -- 高度可扩展
    -- 支持扩展插件，如 Telescope 文件预览、剪贴板历史、Git 分支管理等。
        -- 用户可以根据需求编写自己的扩展。
        -- 直观的界面
    -- 使用浮动窗口和预览界面，便于快速查看搜索结果。
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { -- If encountering errors, see telescope-fzf-native README for installation instructions
            'nvim-telescope/telescope-fzf-native.nvim',
            -- `build` is used to run some command when the plugin is installed/updated.
            -- This is only run then, not every time Neovim starts up.
            build = 'make',

            -- `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
    },
    opts = {
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            -- open files in the first window that is an actual file.
            -- use the current window if no other window is available.
            get_selection_window = function()
              local wins = vim.api.nvim_list_wins()
              table.insert(wins, 1, vim.api.nvim_get_current_win())
              for _, win in ipairs(wins) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].buftype == "" then
                  return win
                end
              end
              return 0
            end,
        },
        extensions = {
            cmdline = {
                picker = {
                    layout_config = {
                        width  = 120,
                        height = 25,
                    }
                },
                mappings = {
                  complete      = '<Tab>',
                  run_selection = '<C-CR>',
                  run_input     = '<CR>',
                },
            },
        }
      }, 
    config = function(_, opts)
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup(opts)
      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
 
      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>k', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols, { desc = '[S]earch [S]ymbols' })
      vim.keymap.set('n', '<leader>w', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>d', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      --vim.keymap.set('n', '<leader>r', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', "gd", builtin.lsp_definitions, { desc = "Goto Definition" })
      vim.keymap.set('n', "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References", nowait = true })
      vim.keymap.set('n', "gI", builtin.lsp_implementations, { desc = "Goto Implementation" })
      vim.keymap.set('n', "gy", builtin.lsp_type_definitions, { desc = "Goto T[y]pe Definition" })
      vim.keymap.set('n', "<leader><space>", ":", {desc = "[S]witch to command mode"})

      vim.keymap.set('n', "<leader>u", "<cmd>TodoTelescope <CR>", {desc = "[T]odo Telescope"})
      vim.keymap.set('n', "<leader>t", "<cmd>ToggleTerm <CR>", {desc = "[T]oggle Terminal"})
      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      -- vim.keymap.set('n', '<leader>s/', function()
      --   builtin.live_grep {
      --     grep_open_files = true,
      --     prompt_title = 'Live Grep in Open Files',
      --   }
      -- end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>n', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  }
