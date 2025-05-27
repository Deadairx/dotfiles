vim.o.number = true
vim.o.relativenumber = true

vim.api.nvim_set_hl(0, 'StatusColumnLineNr', { fg = '#585b70', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'StatusColumnLineNrCursor', { fg = '#f9e2af', bg = 'Black', reverse = true })

vim.o.statuscolumn = table.concat {
  '%@SignCb@', -- Clickable sign column
  '%s', -- Sign column
  '%=', -- Right align
  -- Absolute line number (current line)
  '%#StatusColumnLineNrCursor#',
  "%{v:virtnum == 0 ? (v:lnum == line('.') ? v:lnum : '') : ''}",
  -- Absolute line number (non-current line)
  '%#StatusColumnLineNr#',
  "%{v:virtnum == 0 ? (v:lnum == line('.') ? '' : v:lnum) : ''}",
  -- Padding space (current line)
  '%#StatusColumnLineNrCursor#',
  "%{v:virtnum == 0 ? (v:relnum == 0 ? ' ' : '') : ''}",
  -- Padding space (non-current line)
  '%#StatusColumnLineNr#',
  "%{v:virtnum == 0 ? (v:relnum == 0 ? '' : ' ') : ''}",
  -- Relative line number (current line)
  '%#StatusColumnLineNrCursor#',
  "%-2{v:virtnum == 0 ? (v:relnum == 0 ? v:relnum : '') : ''}",
  -- Relative line number (non-current line)
  '%#StatusColumnLineNr#',
  "%-2{v:virtnum == 0 ? (v:relnum == 0 ? '' : v:relnum) : ''}",
  '│ ', -- Separator
}
