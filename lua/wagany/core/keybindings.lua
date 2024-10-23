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


-- Resize with arrows when using multiple windows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<c-down>", ":resize +2<cr>", opts)
map("n", "<c-right>", ":vertical resize -2<cr>", opts)
map("n", "<c-left>", ":vertical resize +2<cr>", opts)

	-- navigate buffers
map("n", "<tab>", ":bnext<cr>", opts) -- Next Tab 
map("n", "<s-tab>", ":bprevious<cr>", opts) -- Previous tab
map("n", "<leader>h", ":nohlsearch<cr>", opts) -- No highlight search

-- move text up and down
map("n", "<a-j>", "<esc>:m .+1<cr>==gi", opts) -- Alt-j 
map("n", "<a-k>", "<esc>:m .-2<cr>==gi", opts) -- Alt-k
-- visual --
-- stay in indent mode
map("v", "<", "<gv", opts) -- Right Indentation
map("v", ">", ">gv", opts) -- Left Indentation

-- move text up and down
map("v", "<a-j>", ":m .+1<cr>==", opts)
map("v", "<a-k>", ":m .-2<cr>==", opts)

-- Visual Block --
-- Move text up and down
    --Terminal --
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

--Better terminal navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
-- insert --
-- press jk fast to exit insert mode 
map("i", "jk", "<esc>", opts) -- Insert mode -> jk -> Normal mode
map("i", "kj", "<esc>", opts) -- Insert mode -> kj -> Normal mode


-- visual --
-- stay in indent mode
map("v", "<", "<gv", opts) -- Right Indentation
map("v", ">", ">gv", opts) -- Left Indentation

-- move text up and down
map("v", "<a-j>", ":m .+1<cr>==", opts)
map("v", "<a-k>", ":m .-2<cr>==", opts)

-- Visual Block --
-- Move text up and down
    --Terminal --
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

--Better terminal navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)	
