return {
  "https://gitlab.com/pandark/42header-vim",
  ft = {"c", "h"},  -- Only load for C/C++ files
  init = function()
    vim.b.user42 = "yael-idr"      -- Your 42 intra login
    vim.b.mail42 = "yael-idr@student.1337.ma"   -- Your 42 email
    -- Auto-add header when creating new C files
    vim.api.nvim_create_autocmd("BufNewFile", {
      pattern = {"*.c", "*.h"},
      callback = function()
        if vim.fn.line('$') == 1 and vim.fn.getline(1) == '' then
          vim.cmd("FortyTwoHeader")
        end
      end
    })
    -- Auto-update header on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = {"*.c", "*.h"},
      callback = function()
        vim.cmd("FortyTwoHeader")
      end
    })
  end
}
