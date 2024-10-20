	vim.api.nvim_set_keymap('n','<leader>p','"+p',{})

local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

	map('n','<C-h>',':wincmd h<CR>') 
	map('n','<C-j>',':wincmd j<CR>') 
	map('n','<C-k>',':wincmd k<CR>') 
	map('n','<C-l>',':wincmd l<CR>') 
