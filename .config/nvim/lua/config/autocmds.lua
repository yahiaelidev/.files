vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = true
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('terminal-open-custom', { clear = true }),
  callback = function()
    vim.opt.number = true
    vim.opt.relativenumber = true
  end,
})

-- Auto source config
vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('NvimConfigReload', { clear = true }),
  pattern = vim.fn.stdpath 'config' .. '/lua/**/*.lua',
  desc = 'Automatically reload lua config files on save',
  command = 'source %',
})

local augroup = vim.api.nvim_create_augroup('CustomIndent', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'lua' }, -- Apply to C and C++ files
  group = augroup,
  callback = function()
    -- vim.bo.expandtab = true
    -- vim.bo.shiftwidth = 4
    -- vim.bo.tabstop = 4
    -- vim.bo.softtabstop = 4
    -- vim.b.sleuth_automatic = 0
    vim.opt_local.cindent = false
    vim.opt_local.smartindent = false
  end,
})

vim.keymap.set("n", "<space>nr", function()
    local current_file = vim.api.nvim_buf_get_name(0)
    if current_file == "" then
        print("No file is open")
        return
    end

    if not (current_file:match("%.c$") or current_file:match("%.h$")) then
        print("Not a C file (.c or .h)")
        return
    end

    local output_buf = vim.fn.bufnr('Norminette_Output', true)
    vim.cmd('botright 07split | buffer ' .. output_buf)
    
    vim.bo[output_buf].buftype = 'nofile'
    vim.bo[output_buf].bufhidden = 'wipe'
    vim.bo[output_buf].swapfile = false
    vim.bo[output_buf].filetype = 'norminette'
    vim.bo[output_buf].modifiable = true

    vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, {})

    vim.api.nvim_buf_set_lines(output_buf, 0, 0, false, {
        "Norminette results for: "..current_file,
        "----------------------------------------"
    })

    local cmd = "norminette " .. vim.fn.shellescape(current_file)
    local handle = io.popen(cmd)
    if handle then
        local result = {}
        for line in handle:lines() do
            table.insert(result, line)
        end
        handle:close()
        vim.api.nvim_buf_set_lines(output_buf, 2, -1, false, result)
    else
        vim.api.nvim_buf_set_lines(output_buf, 2, -1, false, {"Failed to run norminette"})
    end

    vim.bo[output_buf].modifiable = false

    vim.api.nvim_buf_set_keymap(output_buf, 'n', 'q', '<cmd>close<CR>', {nowait = true, silent = true})
    vim.api.nvim_buf_set_keymap(output_buf, 'n', '<ESC>', '<cmd>close<CR>', {nowait = true, silent = true})

    if vim.api.nvim_buf_line_count(output_buf) <= 2 then
        vim.cmd('close')
    end
end)

vim.cmd([[
    augroup NorminetteHighlight
        autocmd!
        autocmd FileType norminette syn match ErrorMsg 'Error:'
        autocmd FileType norminette syn match WarningMsg 'Warning:'
        autocmd FileType norminette syn match Comment '^Norminette results for:'
        autocmd FileType norminette syn match Underlined '^---'
    augroup END
]])
