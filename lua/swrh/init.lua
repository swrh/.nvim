local M = {}

local load_mapping = function(section)
  for mode, mappings in pairs(section) do
    for keybind, info in pairs(mappings) do
      local opts = vim.tbl_deep_extend('force', { mode = mode }, info.opts or {})
      info.opts, opts.mode = nil, nil
      local action = info[1]
      opts.desc = info[2]
      vim.keymap.set(mode, keybind, action, opts)
    end
  end
end

M.init = function()
  require('swrh.config').load()

  local mappings = require 'swrh.mappings'
  load_mapping(mappings.general)
  load_mapping(mappings.lspconfig)
  load_mapping(mappings.whichkey)
  load_mapping(mappings.gitsigns)
  load_mapping(mappings.telescope)
  load_mapping(mappings.leap)

  -- Restore cursor position
  vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
    pattern = { '*' },
    callback = function()
      vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
  })

  -- makes * and # work on visual mode too.
  vim.api.nvim_exec(
    [[
      function! g:VSetSearch(cmdtype)
        let temp = @s
        norm! gv"sy
        let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
        let @s = temp
      endfunction

      xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
      xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
    ]],
    false
  )
end

return M
