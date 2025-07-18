local spec = { "mfussenegger/nvim-lint" }

spec.enabled = true
spec.event = "VeryLazy"

spec.config = function()
	local lint = require("lint")

	local default_linters_by_ft = {
		lua = { "selene" },
		cmake = { "cmakelint" },
		html = { "markuplint" },
		css = { "stylelint" },
		go = { "golangcilint" },
	}

	-- Check if linting is disabled for this filetype
	local function linting_disabled_for_ft(ft)
		local marker = vim.fn.getcwd() .. "/.disable-lint-" .. ft
		return vim.fn.filereadable(marker) == 1
	end

	-- Dynamically apply linters based on marker
	lint.linters_by_ft = setmetatable({}, {
		__index = function(_, ft)
			if linting_disabled_for_ft(ft) then
				return {}
			else
				return default_linters_by_ft[ft] or {}
			end
		end,
	})

	-- Autocmd to trigger linting
	local lint_augroup = vim.api.nvim_create_augroup("nvim-lint", { clear = true })

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = lint_augroup,
		callback = function()
			lint.try_lint()
		end,
	})

	vim.keymap.set("n", "<leader>l", function()
		lint.try_lint()
	end, { desc = "Lint buffer" })
end

return spec
