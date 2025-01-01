-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.api.nvim_set_keymap

-- 复用 opt 参数
local opt = { noremap = true, silent = true }
--map("n", "r", "<C-r>", opt)
-- 取消 s 默认功能
map("n", "s", "", opt)
-- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- 关闭当前
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt)

map('n', 'yy', '"+yy', { noremap = true, silent = true })
map('n', 'ya', '"ay', { noremap = true, silent = true })

map('v', 'y', '"+y', { noremap = true, silent = true })
map('v', 'ya', '"ay', { noremap = true, silent = true })

map("n", "H", ":BufferLineCyclePrev<CR>", opt)
map("n", "L", ":BufferLineCycleNext<CR>", opt)

map("n", "ff", ":Telescop find_files<CR>", opt)
map( 'n', 'fc',
  [[:lua require('telescope.builtin').find_files({ prompt_title = "Neovim Config", cwd = "~/.config/nvim" })<CR>]],
  { noremap = true, silent = true }
)

map("n", "<C-h>", "<C-w>h", opt)
map("n", "<C-l>", "<C-w>l", opt)
map("n", "<C-j>", "<C-w>j", opt)
map("n", "<C-k>", "<C-w>k", opt)

-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- jump to define
map("n", "<leader>j", "<C-]>", opt)
map("v", "<leader>j", "<C-]>", opt)
map("n", "<leader>k", "<C-o>", opt)
map("v", "<leader>k", "<C-o]>", opt)

map("n", "<leader>l", ":Lazy<CR>", opt)

-- 退出
map("n", "q", ":q<CR>", opt)
map("n", "qq", ":q!<CR>", opt)
map("n", "Q", ":qa!<CR>", opt)
--map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<C-t>", "<C-\\><C-n>", opt)

--cmake
-- map("n", "<leader>cg", ":CMakeGenerate<CR>", opt)
-- map("n", "<leader>cb", ":CMakeBuild<CR>", opt)
-- map("n", "<leader>ci", ":CMakeInstall<CR>", opt)
-- map("n", "<leader>cc", ":CMakeClean<CR>", opt)

-- cpp diagnostics
map("n", "cd", ":Trouble diagnostics toggle<CR>", opt)

function GetCommitSHA()
    local api = vim.api

    local cache = require('gitsigns.cache').cache
    local bufnr = api.nvim_get_current_buf()
    local bcache = cache[bufnr]
    if not bcache then
        return ""
    end
    local blame = assert(bcache.blame)
    local blm_win = api.nvim_get_current_win()
    local cursor = unpack(api.nvim_win_get_cursor(blm_win))
    local cur_sha = blame[cursor].commit.abbrev_sha
    if string.match(cur_sha, "00000000") then
        return ""
    else
        return cur_sha
    end     
end

function DiffviewHistory()
    local cur_sha = GetCommitSHA()
    local api = vim.api
    if cur_sha == "" then
        print("Can't find a valid commit sha")
    else  
        api.nvim_command('DiffviewFileHistory % --range=' .. cur_sha)
    end 
end

function DiffviewCurrentCommit()
    local cur_sha = GetCommitSHA()
    local api = vim.api
    if cur_sha == "" then
        print("Can't find a valid commit sha")
    else  
        api.nvim_command('DiffviewOpen ' .. cur_sha .. "^!")
    end 
end

map("n", "go", ":DiffviewClose<CR>", opt)
map("n", "gh", ":DiffviewOpen<CR>", opt)
map("n", "gb", ":lua DiffviewHistory()<CR>", opt)
map("n", "gB", ":lua DiffviewCurrentCommit()<CR>", opt)

map(
    "n",
    "<leader>de",
    ":lua require'dap'.close()<CR>"
        .. ":lua require'dap'.terminate()<CR>"
        .. ":lua require'dap.repl'.close()<CR>"
        .. ":lua require('dapui').close()<CR>",
    opt
)
map("n", "<leader>dc", ":lua require('dap').clear_breakpoints()<CR>", opt)
map("n", "<leader>dv", ":lua require('dapui').toggle()<CR>", opt)

map("n", "<F5>", ":lua require('dap').continue()<CR>", opt)
map("n", "<F6>", ":lua require('dap').step_over()<CR>", opt)
map("n", "<F7>", ":lua require('dap').step_into()<CR>", opt)
map("n", "<F8>", ":lua require('dap').step_out()<CR>", opt)

map("n", "<F9>", ":lua require('dap').toggle_breakpoint()<CR>", opt)
map("n", "<F10>", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opt)
map("n", "<F11>", ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>", opt)


-- function find_corresponding_file()
--   local telescope = require("telescope.builtin")
--   local Path = require("plenary.path")
--   local current_file = vim.fn.expand("%:t") -- 当前文件名
--   local target_file
--
--   if current_file:match("%.cpp$") then
--     target_file = current_file:gsub("%.cpp$", ".h")
--   elseif current_file:match("%.h$") then
--     target_file = current_file:gsub("%.h$", ".cpp")
--   else
--     vim.notify("current file is not .cpp or .h files", vim.log.levels.WARN)
--     return
--   end
--
--   local search_dir = vim.fn.getcwd() -- 从项目根目录开始
--
--   telescope.find_files({
--     prompt_title = "Find Corresponding File",
--     cwd = search_dir,
--     search_dirs = { search_dir },
--     find_command = { "rg", "--files", "--glob", target_file }, -- 用 rg 定位对应文件
--   })
-- end
--
-- map( "n", "<Leader>tf", ":lua find_corresponding_file()<CR>",
--   { noremap = true, silent = true }
-- )


function find_corresponding_file()
  local Path = require("plenary.path")
  local Job = require("plenary.job")
  local current_file = vim.fn.expand("%:t") -- Get current file name
  local target_file

  -- Determine the corresponding file extension
  if current_file:match("%.cpp$") then
    target_file = current_file:gsub("%.cpp$", ".h")
  elseif current_file:match("%.h$") then
    target_file = current_file:gsub("%.h$", ".cpp")
  else
    vim.notify("Current file is not a .cpp or .h file", vim.log.levels.WARN)
    return
  end

  -- Search for the target file using ripgrep
  Job:new({
    command = "rg",
    args = { "--files", "--glob", target_file, "--hidden", "--no-ignore" },
    cwd = vim.fn.getcwd(),
    on_exit = function(job, return_val)
      vim.schedule(function() -- Ensure code runs in Neovim's main loop
        if return_val ~= 0 then
          vim.notify("No corresponding file found for: " .. target_file, vim.log.levels.WARN)
          return
        end

        local results = job:result()
        if #results == 0 then
          vim.notify("No corresponding file found for: " .. target_file, vim.log.levels.WARN)
        elseif #results == 1 then
          -- Open the file directly if only one match is found
          vim.cmd("edit " .. results[1])
        else
          -- Use Telescope to show multiple matches
          require("telescope.builtin").find_files({
            prompt_title = "Find Corresponding File",
            cwd = vim.fn.getcwd(),
            default_text = target_file,
            find_command = { "rg", "--files", "--glob", target_file, "--hidden", "--no-ignore" },
          })
        end
      end)
    end,
  }):start()
end

-- Map the function to a key
map( "n", "<Leader>cf", ":lua find_corresponding_file()<CR>",
  { noremap = true, silent = true }
)

