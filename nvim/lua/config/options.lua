-- Indentation

-- Set indenting to 4 spaces
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4


-- Search

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true


-- Side bar and line

-- Show which line the cursor is on
vim.opt.cursorline = true
-- Make line numbers default
vim.opt.number = true
-- Relative line numbers
vim.opt.relativenumber = false
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'
-- Wrap long lines
vim.opt.wrap = false


-- System

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  See `:help 'clipboard'`
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)
-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'
-- Enables 24-bit RGB colors
vim.opt.termguicolors = true
-- Enable undo/redo changes even after closing and reopening a file
vim.opt.undofile = true
-- Decrease update time
vim.opt.updatetime = 250


-- Typing

-- Enable break indent
vim.opt.breakindent = true
-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300


-- UI

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt.t` instead of `vim.opt..
--  It is very similar to `vim.opt. but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
--vim.opt.list = true
--vim.opt.t.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
-- Configure how new splits should be opened
vim.opt.splitbelow = true
vim.opt.splitright = true

