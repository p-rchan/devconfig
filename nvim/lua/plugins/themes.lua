return {
	{
		-- Theme inspired by Atom
		"navarasu/onedark.nvim",
		priority = 1000,
		opts = {
			style = "deep",
		},
	},
	{
		-- Theme inspired by Atom
		"folke/tokyonight.nvim",
		lazy = false, --load during startup
		priority = 1000, --load before all other start plugins
		enabled = true,
		opts = {},
	},
	{
		"nvim-zh/colorful-winsep.nvim",
		config = true,
		event = { "WinLeave" },
	},
}
