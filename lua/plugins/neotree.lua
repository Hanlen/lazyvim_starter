return {
    -- 显示项目目录结构，方便快速浏览和打开文件。
    -- 支持文件和目录的创建、删除、重命名、复制、移动等操作
    -- 显示文件的 Git 状态（新增、修改、删除等）, 快速了解项目中的文件更改情况
    -- 支持模糊搜索、正则过滤，快速定位目标文件。
    -- 根据文件名、类型或 Git 状态筛选内容。
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
        { '<leader>e', '<Cmd>Neotree toggle<CR>', desc = '[T]oggle NeoTree', silent = true },
        {
            "<leader>ge",
            function()
            require("neo-tree.command").execute({ source = "git_status", toggle = true })
            end,
            desc = "Git Explorer",
        },
    },
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    init = function()
        -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
        -- because `cwd` is not set up properly.
        vim.api.nvim_create_autocmd("BufEnter", {
          group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
          desc = "Start Neo-tree with directory",
          once = true,
          callback = function()
            if package.loaded["neo-tree"] then
              return
            else
              local stats = vim.uv.fs_stat(vim.fn.argv(0))
              if stats and stats.type == "directory" then
                require("neo-tree")
              end
            end
          end,
        })
    end,
    opts = {
        enable_git_status = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        sort_function = nil , -- use a custom function for sorting files and directories in the tree 
        sources = { "filesystem", "buffers", "git_status" },
        default_component_configs = {
            indent = {
                highlight = "NeoTreeIndentMarker",
                -- expander config, needed for nesting files
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "",
                default = "*",
                highlight = "NeoTreeFileIcon"
            },
            
            git_status = {
                symbols = {
                    -- Status type
                    untracked = "",
                    ignored   = "",
                    unstaged  = "󰄱",
                    staged    = "",
                    conflict  = "",
                }
            },
        },
        window = {
            mappings = {
              ["l"] = "open",
              ["h"] = "close_node",
              ["<space>"] = "none",
              ["y"] = {
                function(state)
                  local node = state.tree:get_node()
                  local path = node:get_id()
                  vim.fn.setreg("+", path, "c")
                end,
                desc = "Copy Path to Clipboard",
              },
              ["O"] = {
                function(state)
                  require("lazy.util").open(state.tree:get_node().path, { system = true })
                end,
                desc = "Open with System Application",
              },
              ["P"] = { "toggle_preview", config = { use_float = false } },
            },
        },
        filesystem = {
            filtered_items = {
                visible = true,
                show_hidden_count = true,
                hide_dotfiles = false,
                hide_gitignored = true,
                hide_by_name = {
                    --'.git', '.DS_Store',  -- 'thumbs.db',
                },
                never_show = {'.git'},
            },
        }
    },
}
