return {

  'cacharle/c_formatter_42.vim',
  ft = { 'c', 'h' },

  init = function()
    vim.g.c_formatter_42_set_equalprg = 1
    vim.g.c_formatter_42_format_on_save = 0

    -- Add <leader>nc mapping for C formatter
    vim.keymap.set('n', '<leader>nc', function()
      vim.cmd('CFormatter42')
    end, { silent = true, desc = 'Format C code with c_formatter_42' })

  end,

}
