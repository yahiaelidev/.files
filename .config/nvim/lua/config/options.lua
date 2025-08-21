vim.g.c_indent_off = 1
vim.o.signcolumn = "yes"
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 4 -- Amount to indent with << and >>
vim.opt.tabstop = 4 -- How many spaces are shown per Tab
vim.opt.softtabstop = 4 -- How many spaces are applied when pressing Tab
-- vim.opt.nohlsearch = 0;

-- vim.opt.smarttab = true
-- vim.opt.smartindent = true
vim.opt.autoindent = true -- Keep identation from previous line

-- Enable break indent
vim.opt.breakindent = true

-- Always show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Show line under cursor
vim.opt.cursorline = true

-- Store undos between sessions
vim.opt.undofile = true

vim.opt.scrolloff = 10
vim.opt.confirm = true
vim.opt.numberwidth = 6
vim.opt.swapfile = false
vim.opt.showtabline = 2

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

vim.opt.wrap = false
vim.opt.linebreak = true

vim.opt.splitright = true
vim.opt.splitbelow = true
