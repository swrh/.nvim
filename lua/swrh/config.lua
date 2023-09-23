local M = {}

M.load = function()
  vim.o.hlsearch = true

  vim.o.clipboard = ''

  vim.o.smartindent = true

  -- vim.o.expandtab = true
  -- vim.o.shiftwidth = 2
  -- vim.o.tabstop = 2
  -- vim.o.softtabstop = 2

  vim.o.number = true
  vim.o.relativenumber = true
  vim.o.numberwidth = 3
  vim.o.ruler = true

  vim.o.splitbelow = true
  vim.o.splitright = true

  vim.o.autowrite = true

  vim.o.list = true
  vim.o.listchars = 'tab:>.,trail:.,eol:$'
end

return M
