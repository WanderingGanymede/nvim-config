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
