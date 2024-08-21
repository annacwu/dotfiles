return {
	{
	    "nvim-telescope/telescope-file-browser.nvim",
	    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	},
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
	},
	{
	    'nvim-lualine/lualine.nvim',
	    dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
		    icons_enabled = true,
		    theme = 'auto',
		    component_separators = { left = '', right = ''},
		    section_separators = { left = '', right = ''},
		    disabled_filetypes = {
		      statusline = {},
		      winbar = {},
		    },
		    ignore_focus = {},
		    always_divide_middle = true,
		    globalstatus = false,
		    refresh = {
		      statusline = 1000,
		      tabline = 1000,
		      winbar = 1000,
		    }
		  }
	},
	{
		"jiangmiao/auto-pairs"
	},
	{
		"savq/melange-nvim",
		lazy = false,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
	},
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/nvim-cmp",
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
}
