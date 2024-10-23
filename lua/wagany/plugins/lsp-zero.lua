return
{
	'VonHeikemen/lsp-zero.nvim',
	name = 'lsp-zero',
	branch = 'v4.x',
	dependencies = {
		-- LSP Support
		{ 'neovim/nvim-lspconfig' },       -- Required
		{ 'williamboman/mason.nvim' },     -- Optional
		{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

		-- Autocompletion
		{ 'hrsh7th/nvim-cmp' },   -- Required
		{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
		{ 'hrsh7th/cmp-buffer' }, -- Optional
		{ 'hrsh7th/cmp-path' },   -- Optional
		{ 'saadparwaiz1/cmp_luasnip' }, -- Optional
		{ 'hrsh7th/cmp-nvim-lua' }, -- Optional

		{ 'habamax/vim-godot',                event = 'VimEnter' },
		-- Snippets
		{ 'L3MON4D3/LuaSnip' },       -- Required
		{ 'rafamadriz/friendly-snippets' }, -- Optional
	},
	config = function()
		vim.opt.signcolumn = 'yes'
		local lspconfig_defaults = require('lspconfig').util.default_config
		-- Add cmp_nvim_lsp capabilities settings to lspconfig
		-- This should be executed before you configure any language server
		local lspconfig_defaults = require('lspconfig').util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			'force',
			lspconfig_defaults.capabilities,
			require('cmp_nvim_lsp').default_capabilities()
		)

		-- This is where you enable features that only work
		-- if there is a language server active in the file
		vim.api.nvim_create_autocmd('LspAttach', {
			desc = 'LSP actions',
			callback = function(event)
				local opts = { buffer = event.buf }

				vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
				vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
				vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
				vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
				vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
				vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
				vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
				vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
				vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
				vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
			end,
		})

		local cmp = require('cmp')
		cmp.setup({
			sources = {
				{ name = 'nvim_lsp' },
			},
			snippet = {
				expand = function(args)
					-- You need Neovim v0.10 to use vim.snippet
					vim.snippet.expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				-- Navigate between completion items
				['<C-p>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
				['<C-n>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
				-- `Enter` key to confirm completion
				['<CR>'] = cmp.mapping.confirm({ select = false }),
				-- Ctrl+Space to trigger completion menu
				['<C-Space>'] = cmp.mapping.complete(),
				-- Scroll up and down in the completion documentation
				['<C-u>'] = cmp.mapping.scroll_docs(-4),

				['<C-d>'] = cmp.mapping.scroll_docs(4),
			}),
		})

		require('mason').setup({})
		require('mason-lspconfig').setup({
			-- Replace the language servers listed here
			-- with the ones you want to install
			ensure_installed = { 'lua_ls', 'rust_analyzer' },
			handlers = {
				function(server_name)
					require('lspconfig')[server_name].setup({})
				end,

				lua = function()
					require('lspconfig').lua_ls.setup({
						on_attach = function(client, bufnr)
							print('hello lua ls')
						end
					})
				end,
			}
		})

		local lsp_zero = require('lsp-zero')
		-- don't add this function in the `LspAttach` event.
		-- `format_on_save` should run only once.
		lsp_zero.format_on_save({
			format_opts = {
				async = false,
				timeout_ms = 9999,
			},
			servers = {
				['lua_ls'] = { 'lua' },
			}
		})

		vim.api.nvim_create_autocmd('LspAttach', {

			callback = function(event)
				local opts = { buffer = event.buf }



				vim.keymap.set({ 'n', 'x' }, 'gq', function()
					vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
				end, opts)
			end

		})
	end


}