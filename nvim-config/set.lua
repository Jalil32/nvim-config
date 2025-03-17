-- Set the leader key to the spacebar
vim.g.mapleader = " "
vim.g.netrw_banner = 0

-- General Settings
local opt = vim.opt
opt.signcolumn = "no"
opt.nu = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.numberwidth = 2 -- Width of the number column
opt.cmdheight = 2 -- Height of the command bar
opt.mouse = "a" -- Enable mouse in all modes
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true -- Override ignore case if the search has uppercase letters
opt.wrap = false -- Disable line wrapping
opt.scrolloff = 20 -- Minimum number of lines to keep above/below the cursor
opt.sidescrolloff = 8 -- Minimum number of columns on the left/right of the cursor
opt.pumheight = 10 -- Height of the pop-up menu
opt.fileencoding = "utf-8" -- Set file encoding to UTF-8
opt.expandtab = false -- Use actual tab characters instead of spaces
opt.tabstop = 4 -- Number of spaces a tab counts for
opt.shiftwidth = 4 -- Number of spaces for each indentation level
opt.softtabstop = 4 -- Makes the tab size consistent when editing text
opt.smartindent = true -- Enable smart indentation
opt.autoindent = true -- Enable automatic indentation
opt.timeoutlen = 1000 -- Time to wait for a mapped sequence (in ms)
opt.completeopt = "menuone,noselect" -- Autocompletion settings
opt.splitbelow = true -- Force horizontal splits to go below the current window
opt.splitright = true -- Force vertical splits to go to the right of the current window
opt.clipboard = "unnamedplus" -- Sync clipboard with system clipboard
opt.swapfile = false -- Disable swap files
opt.cursorline = false -- Disable highlighting the current line
opt.conceallevel = 0 -- Show text normally (no concealment)
opt.signcolumn = "yes" -- Always show the sign column
opt.undofile = true -- Enable persistent undo

-- Additional Key Mappings
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- <leader>pv opens the file explorer (Ex command)

-- In Visual mode:
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move selected lines down and keep cursor in place
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Move selected lines up and keep cursor in place

-- Buffer Navigation:
vim.api.nvim_set_keymap("n", "<A-6>", ":bprev<CR>", { noremap = true, silent = true }) -- Alt + 6 to go to previous buffer
vim.api.nvim_set_keymap("n", "<C-6>", "<C-^>", { noremap = true, silent = true }) -- Ctrl + 6 to toggle between two files

-- Set background to transparent (UI customization)
vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) -- Transparent background for Normal mode
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }) -- Transparent background for floating windows
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" }) -- Transparent background for Normal in non-current windows
vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" }) -- Transparent background for the Status Line
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" }) -- Transparent background for the Status Line in non-current windows

-- Wrap settings
opt.whichwrap:append("b,s,<,>,[,],h,l") -- Allow certain keys to move between lines (e.g., < and >)
opt.shortmess:append("c") -- Shorten certain messages in the command line
opt.showmode = false -- Disable showing mode in the command bar (use statusline for mode indication)
