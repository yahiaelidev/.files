return {
  'rose-pine/neovim',
  enabled = false,
  name = 'rose-pine',
  config = function()
    require('rose-pine').setup {
      variant = 'main',
      dim_inactive_windows = false,
      disable_background = false,
      palette = {
        main = {
          pine = '#3e8fb0',
          comment = '#363738',
          gold = '#ffd59c',
        },
      },
      highlight_groups = {
        Comment = { fg = 'comment' },
        -- StatusLine = { fg = "love", bg = "love", blend = 15 },
        -- VertSplit = { fg = "muted", bg = "muted" },
        -- Visual = { fg = "base", bg = "text", inherit = false },
      },
    }
    vim.cmd 'colorscheme rose-pine'
  end,
}
