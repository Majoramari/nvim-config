local function wakatime_today_component()
	local cli_output = "󰞌 Loading..."
	local interval_time = 300000

	-- Function to update CLI output asynchronously
	local function update_cli_output()
		vim.loop.spawn("wakatime-cli", { args = { "--today" } }, function(code)
			vim.schedule(function()
				if code == 0 then
					local handle = io.popen("wakatime-cli --today")
					if handle then
						cli_output = "󱑆 " .. handle:read("*a"):gsub("%s+$", "") -- Trim trailing whitespace
						handle:close()
					end
				else
					cli_output = "󱑆 Error"
				end
			end)
		end)
	end

	-- Initial update and set up a timer to update every 60 seconds
	update_cli_output()
	vim.loop.new_timer():start(interval_time, interval_time, vim.schedule_wrap(update_cli_output))

	-- Return the latest output for lualine
	return function()
		return cli_output
	end
end

return {
	"nvim-lualine/lualine.nvim",
	event = { "BufReadPre", "BufNewFile" },
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
				lualine_y = { "filetype", { wakatime_today_component() } },
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
