
return{
		-- "shaunsingh/solarized.nvim",
		"shaunsingh/nord.nvim",
		priority = 1000,
		config= function()
			vim.cmd("colorscheme nord")
		end,
	}
