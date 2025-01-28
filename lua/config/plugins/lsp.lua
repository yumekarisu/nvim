return {
    {
	"neovim/nvim-lspconfig",
	dependencies = {
	    {
		"williamboman/mason.nvim",
		opts = {},
	    },
	    "williamboman/mason-lspconfig.nvim",
	    "WhoIsSethDaniel/mason-tool-installer.nvim",
	    "saghen/blink.cmp",
	    {
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
		    library = {
			-- See the configuration section for more details
			-- Load luvit types when the `vim.uv` word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		    },
		},
	    },
	},
	config = function()
	    local capabilities = require("blink.cmp").get_lsp_capabilities()

	    require('mason-tool-installer').setup {
		ensure_installed = {
		    "lua-language-server",
		    "clangd"
		}
	    }
	    require("mason-lspconfig").setup()

	    require("lspconfig").lua_ls.setup {
		capabilities = capabilities
	    }

	    require("lspconfig").clangd.setup {
		capabilities = capabilities
	    }
	end
    }
}
