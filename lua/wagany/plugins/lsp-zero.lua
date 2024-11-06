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
				{ name = 'buffer' },
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
				['<Tab>'] = cmp.mapping.confirm({ select = true }),
				['<CR>'] = cmp.mapping.confirm({ select = false }),
				-- Ctrl+Space to trigger completion menu
				['<C-Space>'] = cmp.mapping.complete(),
				-- Scroll up and down in the completion documentation
				['<C-u>'] = cmp.mapping.scroll_docs(-4),

				['<C-d>'] = cmp.mapping.scroll_docs(4),
			}),

		})

		local gdscript_config = {
			capabilities = capabilities,
			settings = {},
		}
		if vim.fn.has 'win32' == 1 then
			gdscript_config['cmd'] = { 'ncat', 'localhost', os.getenv 'GDScript_Port' or '6005' }
		end

		--------------
		------------  LSP CONFIG
		--------------
		--------------
		local lspconfig = require('lspconfig')
		lspconfig.gdscript.setup(gdscript_config)

		lspconfig.pylsp.setup {}

		lspconfig.nixd.setup {}

		lspconfig.lua_ls.setup {
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = 'LuaJIT'
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME
							-- Depending on the usage, you might want to add additional paths here.
							-- "${3rd}/luv/library"
							-- "${3rd}/busted/library",
						}
						-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
						-- library = vim.api.nvim_get_runtime_file("", true)
					}
				})
			end,
			settings = {
				Lua = {}
			}
		}

		require('mason').setup({})
		require('mason-lspconfig').setup({
			-- Replace the language servers listed here
			-- with the ones you want to install
			ensure_installed = {},
			handlers = {
				function(server_name)
					require('lspconfig')[server_name].setup({})
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
