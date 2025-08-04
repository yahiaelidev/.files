vim.g.have_nerd_font = true
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require 'config.options'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})

    vim.fn.getchar()

    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  change_detection = {
    enabled = true,
    notify = false,
  },
  
  performance = {
    cache = {
      enabled = true,
    }
  },

  spec = {
    { import = 'plugins' },
  },

  install = { colorscheme = { 'vague' } },
  checker = { enabled = true, notify = false },

  ui = {
    -- Fallback icons if Nerd Font isn't available
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤',
    },
  },
})

require 'config.keymaps'
require 'config.autocmds'
