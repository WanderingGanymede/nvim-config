local on_attach=function ( _, bufnr)

	local bufmap =function (keys, func)
		vim.keymap.set('n',keysmfunc,{buffer=bufnr})
	end

	bufmap('<leader>r', vim.lsp.buf.rename)
	bufmap('<leader>a', vim.lsp.buf.code_action)
	
	bufmap('gd', vim.lsp.buf.definition)
	bufmap('gD', vim.lsp.buf.declaration)
	bufmap('gI', vim.lsp.buf.implementation)
	bufmap('<leader>D', vim.lsp.buf.type_definition)

	
	--bufmap('gr', require('telescope.builtin').lsp_references)
	--bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
	--bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)
	
	bufmap('K',vim.lsp.buf.hover)

	bufmap('<leader>f',vim.lsp.buf.format)


end

require("mason").setup()
require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup{

			on_attach=on_attach,
			capabilities=capabilities
		}
	end,

	["lua_ls"] =function()
		require('lspconfig').lua_ls.setup{
			on_attach=on_attach,
			capabilities=capabilities,
			Lua= {
				workspace={checkThirdParty=false},
				telemetry={enable=false},
			},
		}
		end

})

