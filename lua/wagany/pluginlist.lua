return {

	{
		"numToStr/Comment.nvim",
		config= function()
			require("Comment").setup()
		end
	},
	{
		-- "shaunsingh/solarized.nvim",
		"shaunsingh/nord.nvim",
		priority = 1000,
		config= function()
			vim.cmd("colorscheme nord")
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies= {
			"nvim-tree/nvim-web-devicons"
		},
		config= function()
			require("lualine").setup({
				icons_enabled=true,
				theme= 'nord',
			})
		end,
	},

	-- "williamboman/mason.nvim",
	-- "williamboman/mason-lspconfig.nvim",
	-- "neovim/nvim-lspconfig",




	{
		"nvim-tree/nvim-tree.lua",





		config= function()
			local nvimtree= require ("nvim-tree")

			vim.g.loaded_netrw=1
			vim.g.loaded_netrwPlugin =1
			
			   -- change color for arrows in tree to light blue
			vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
			vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

    -- configure nvim-tree
			nvimtree.setup({
			  view = {
				width = 35,
				relativenumber = true,
			  },
			  -- change folder arrow icons
			  renderer = {
				indent_markers = {
				  enable = true,
				},
				icons = {
				  glyphs = {
					folder = {
					  arrow_closed = "", -- arrow when folder is closed
					  arrow_open = "", -- arrow when folder is open
					},
				  },
				},
			  },
			  -- disable window_picker for
			  -- explorer to work well with
			  -- window splits
			  actions = {
				open_file = {
				  window_picker = {
					enable = false,
				  },
				},
			  },
			  filters = {
				custom = { ".DS_Store" },
			  },
			  git = {
				ignore = false,
			  },
			})

			-- set keymaps
			local keymap = vim.keymap -- for conciseness

			keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) 
			-- toggle file explorer
			keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) 
			-- toggle file explorer on current file
			keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
			-- collapse file explorer
			keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
			-- refresh file explorer

		end

	},

	--
	--
	--
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	dependencies ={
	-- 		'L3MON4D3/LuaSnip',
	-- 		'saadparwaiz1/cmp_luasnip',
	-- 		'rafamadriz/friendly-snippets',
	-- 		'hrsh7th/cmp-nvim-lsp',
	-- 	},
	-- },
}
