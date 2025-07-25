local tb = require("telescope.builtin")
local themes = require("telescope.themes")
local actions = require("telescope.actions")

local find_files = {
	"<leader>ff",
	function()
		tb.find_files()
	end,
	desc = "Find files",
	noremap = true,
	silent = true,
}

local live_grep = {
	"<leader>fg",
	function()
		tb.live_grep()
	end,
	desc = "Live Grep",
	noremap = true,
	silent = true,
}

local buffers = {
	"<leader>fb",
	function()
		tb.buffers()
	end,
	desc = "Running buffers",
	noremap = true,
	silent = true,
}

local edit_nvim_config = {
	"<leader>fn",
	function()
		tb.find_files({
			cwd = vim.fn.stdpath("config"),
		})
	end,
	desc = "Find files",
	noremap = true,
	silent = true,
}

local help_tags = {
	"<leader>fh",
	function()
		tb.help_tags({
			enable_preview = true,
		})
	end,
	desc = "Find help tags",
	noremap = true,
	silent = true,
}

local colorscheme = {
	"<leader>ft",
	function()
		tb.colorscheme({
			enable_preview = true,
			attach_mappings = function(_, map)
				map("i", "<CR>", function(prompt_bufnr)
					local state = require("telescope.actions.state")
					local theme = state.get_selected_entry().value
					actions.close(prompt_bufnr)

					-- Apply the selected colorscheme
					vim.cmd.colorscheme(theme)

					-- Save the theme name to a file
					local theme_file = vim.fn.stdpath("config") .. "/theme.txt"
					vim.fn.writefile({ theme }, theme_file)
				end)
				return true
			end,
		})
	end,
	desc = "Pick colorscheme with preview",
	noremap = true,
	silent = true,
}

return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	tag = "0.1.8",
	dependencies = {
		"nvim-telescope/telescope-ui-select.nvim",
		{ "echasnovski/mini.icons", version = "*" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		find_files,
		live_grep,
		buffers,
		edit_nvim_config,
		colorscheme,
		help_tags,
	},
	config = function()
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<esc>"] = actions.close,
					},
				},
				border = true,
				-- use a "single" box everywhere (clockwise from top-left)
				borderchars = {
					prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				},
			},
			pickers = {
				colorscheme = {
					theme = "dropdown",
				},
				help_tags = {
					theme = "dropdown",
				},
				buffers = {
					mappings = {
						i = {
							["<c-d>"] = actions.delete_buffer + actions.move_to_top,
						},
					},
				},
			},
			extensions = {
				["ui-select"] = {
					themes.get_dropdown({}),
				},
				fzf = {},
			},
		})

		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("fzf")
	end,
}
