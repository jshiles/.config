-- ===================================================================
-- GENERAL SETTINGS
-- ===================================================================
-- These are basic Neovim settings for a better user experience.

vim.g.mapleader = " " -- Set the leader key to Space
vim.g.maplocalleader = " " -- Set the local leader key to Space

local opt = vim.opt -- A shorthand for vim.opt

-- Line numbers
opt.relativenumber = true -- Show relative line numbers
opt.number = true -- Show the absolute line number for the current line

-- Tabs and indentation
opt.tabstop = 4 -- Number of spaces a <Tab> in the file counts for
opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
opt.expandtab = true -- Use spaces instead of tabs
opt.autoindent = true -- Copy indent from current line when starting a new line

-- Search settings
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override ignorecase if the search pattern contains uppercase letters

-- Appearance
opt.termguicolors = true -- Enable 24-bit RGB color in the TUI
opt.wrap = false -- Do not wrap lines
opt.cursorline = true -- Highlight the current line

-- Behavior
opt.scrolloff = 16 -- Keep 16 lines of context around the cursor
opt.sidescrolloff = 16

-- Set basic Neovim optionsdd
vim.o.number = true -- Enable line numbers
vim.o.relativenumber = true -- Enable relative line numbers
vim.o.tabstop = 4 -- Set tab width to 4 spaces
vim.o.shiftwidth = 4 -- Set auto-indent width to 4 spaces
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.wrap = false -- Disable line wrapping
vim.o.hlsearch = true -- Highlight search results
vim.o.incsearch = true -- Incremental search

