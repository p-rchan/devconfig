return {

	-- NOTE: This is where your plugins related to LSP can be installed.
	--  The configuration is done below. Search for lspconfig to find it below.
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			--'folke/neodev.nvim',
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "pylsp", "lua_ls" },
			})
			
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local settings = {}
					if server_name == "pylsp" then
						settings = {
							pylsp = {
								plugins = {
									pycodestyle = { enabled = false, maxLineLength = 140, ignore = { "E501" } },
									pylint = { enabled = false },
									flake8 = { enabled = false },
									mccabe = { enabled = false },
									pyflakes = { enabled = false },
								},
							},
						}
					elseif server_name == "lua_ls" then
						settings = {
							Lua = {
								workspace = { checkThirdParty = false },
								telemetry = { enable = false },
							},
						}
					end
					
					require("lspconfig")[server_name].setup({
						settings = settings,
					})
				end,
			})
		end,
	},
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			"L3MON4D3/LuaSnip",
			--"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = function(_, opts)
			-- Disable snippets in markdown files
			if vim.bo.filetype == "markdown" then
				opts.sources = vim.tbl_filter(function(source)
					return source.name ~= "luasnip"
				end, opts.sources)
			else
				--Keep the Original Config for everything else
				opts.sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}
			end
		end,
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
