return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = false,
				theme = "auto",
				globalstatus = true,
				disabled_filetypes = { "alpha" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { "lsp_status", "buffers", "searchcount" },
				lualine_x = {},
				lualine_y = { "filetype" },
				lualine_z = {
					{
						"macro",
						fmt = function()
							local reg = vim.fn.reg_recording()
							if reg ~= "" then
								return "Recording @" .. reg
							end
							return nil
						end,
						draw_empty = false,
					},
					"progress",
				},
			},
		})
	end,
}
