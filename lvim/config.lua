-- install plugins
lvim.plugins = {
	"ChristianChiarulli/swenv.nvim",
	"stevearc/dressing.nvim",
	"mfussenegger/nvim-dap-python",
	"nvim-neotest/neotest",
	"nvim-neotest/neotest-python",
	{ "lunarvim/lunar.nvim" },
	{ "morhetz/gruvbox" },
	{ "sainnhe/gruvbox-material" },
	{ "sainnhe/sonokai" },
	{ "sainnhe/edge" },
	{ "lunarvim/horizon.nvim" },
	{ "tomasr/molokai" },
	{ "ayu-theme/ayu-vim" },
	{ "christoomey/vim-tmux-navigator" },
	{ "tpope/vim-repeat" },
	{ "tpope/vim-surround" },
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup()
		end,
	},
}

local themes = {
	gruvbox = "gruvbox",
	rose_pine = "rose-pine",
	lunar = "lunar",
	gruvbox_material = "gruvbox-material",
	onedarker = "onedarker",
	onedark = "onedark",
	horizon = "horizon",
	tokyonight = "tokyonight",
	tokyonight_night = "tokyonight-night",
	tokyonight_day = "tokyonight-day",
	tokyonight_moon = "tokyonight-moon",
	desert = "desert",
	morning = "morning",
	sonokai = "sonokai",
	edge = "edge",
	ayu = "ayu",
}

-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
	"python",
}

-- setup formatting
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({ { name = "black" } })
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }

-- setup linting
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({ { command = "flake8", filetypes = { "python" } } })

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
pcall(function()
	require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- setup testing
require("neotest").setup({
	adapters = {
		require("neotest-python")({
			-- Extra arguments for nvim-dap configuration
			-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
			dap = {
				justMyCode = false,
				console = "integratedTerminal",
			},
			args = { "--log-level", "DEBUG", "--quiet" },
			runner = "pytest",
		}),
	},
})

lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>", "Test Method" }
lvim.builtin.which_key.mappings["dM"] =
	{ "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
	"<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
	"Test Class",
}
lvim.builtin.which_key.mappings["dF"] = {
	"<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
	"Test Class DAP",
}
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }

-- binding for switching
lvim.builtin.which_key.mappings["C"] = {
	name = "Python",
	c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

lvim.transparent_window = true
vim.opt.relativenumber = true

-- normal mode (easymotion-like)
vim.api.nvim_set_keymap("n", "<Leader><Leader>b", "<cmd>HopWordBC<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader><Leader>w", "<cmd>HopWordAC<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader><Leader>j", "<cmd>HopLineAC<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader><Leader>k", "<cmd>HopLineBC<CR>", { noremap = true })

-- visual mode (easymotion-like)
vim.api.nvim_set_keymap("v", "<Leader><Leader>w", "<cmd>HopWordAC<CR>", { noremap = true })
vim.api.nvim_set_keymap("v", "<Leader><Leader>b", "<cmd>HopWordBC<CR>", { noremap = true })
vim.api.nvim_set_keymap("v", "<Leader><Leader>j", "<cmd>HopLineAC<CR>", { noremap = true })
vim.api.nvim_set_keymap("v", "<Leader><Leader>k", "<cmd>HopLineBC<CR>", { noremap = true })

-- normal mode (sneak-like)
vim.api.nvim_set_keymap("n", "s", "<cmd>HopChar2AC<CR>", { noremap = false })
vim.api.nvim_set_keymap("n", "S", "<cmd>HopChar2BC<CR>", { noremap = false })

-- visual mode (sneak-like)
vim.api.nvim_set_keymap("v", "s", "<cmd>HopChar2AC<CR>", { noremap = false })
vim.api.nvim_set_keymap("v", "S", "<cmd>HopChar2BC<CR>", { noremap = false })
