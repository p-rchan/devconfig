return {

	-- NOTE: This is where your plugins related to LSP can be installed.
	--  The configuration is done below. Search for lspconfig to find it below.
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			--'folke/neodev.nvim',
		},
		config = function()
			--print("LSPConfig for pylsp is being loaded...")
			-- Ensure mason
			require("mason").setup()
			require("mason-lspconfig").setup()
			-- configure pylsp
			-- NOTE - none of this (below) worked.  Switched to using a pycodestyle config which needs to be linked
			local pylsp_config = {
				settings = {
					pylsp = {
						--configurationSources = { "pycodestyle" },
						plugins = {
							pycodestyle = {
								enabled = false,
								maxLineLength = 140,
								ignore = { "E501" },
							},
							pylint = { enabled = false },
							flake8 = { enabled = false },
							mccabe = { enabled = false },
							pyflakes = { enabled = false },
						},
					},
				},
			}
			--print(vim.inspect(pylsp_config))
			require("lspconfig").pylsp.setup(pylsp_config)
			--print("LSPConfig for pylsp is done loaded...")
		end,
	},
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			--"L3MON4D3/LuaSnip",
			--"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",

			-- Adds a number of user-friendly snippets
			--"rafamadriz/friendly-snippets",
		},
	},
	{
		-- Diagnostic windows
		"folke/trouble.nvim",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
	{
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		opts = {},
	},
}
