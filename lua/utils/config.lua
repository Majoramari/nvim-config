local M = {}
local config_path = vim.fn.stdpath("config") .. "/config.toml"

-- Initialize config with defaults
M.default_config = [[
# Neovim Configuration
theme = "catppuccin"
]]

-- Read config file
function M.load()
	local file = io.open(config_path, "r")
	if not file then
		-- Create default config if missing
		local default_file = io.open(config_path, "w")
		if default_file then
			default_file:write(M.default_config)
			default_file:close()
		end
		return M.parse(M.default_config)
	end

	local content = file:read("*a")
	file:close()
	return M.parse(content)
end

-- Simple TOML parser
function M.parse(toml)
	local config = {}
	for line in toml:gmatch("[^\r\n]+") do
		-- Skip comments and empty lines
		if not line:match("^%s*#") and line:match("=") then
			local key, value = line:match("^%s*([%w_]+)%s*=%s*(.+)%s*$")
			if key and value then
				-- Remove surrounding quotes if present
				value = value:gsub('^"(.*)"$', "%1")
				-- Convert booleans and numbers
				if value == "true" then
					value = true
				elseif value == "false" then
					value = false
				elseif tonumber(value) then
					value = tonumber(value)
				end
				config[key] = value
			end
		end
	end
	return config
end

-- Update config value
function M.update_setting(key, value)
	local config = M.load()
	config[key] = value

	-- Rebuild TOML content
	local lines = { "# Neovim Configuration" }
	for k, v in pairs(config) do
		if type(v) == "string" then
			table.insert(lines, string.format('%s = "%s"', k, v))
		else
			table.insert(lines, string.format("%s = %s", k, tostring(v)))
		end
	end

	-- Write to file
	local file = io.open(config_path, "w")
	if file then
		file:write(table.concat(lines, "\n"))
		file:close()
	end
end

-- Apply config on startup
function M.apply()
	local config = M.load()
	pcall(vim.cmd.colorscheme, config.theme or "catppuccin")
end

return M
