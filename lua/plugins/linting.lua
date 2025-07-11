local spec = { "mfussenegger/nvim-lint" }

spec.enabled = true
spec.lazy = true
spec.event = { "BufReadPre", "BufNewFile" }

spec.config = function()
	local lint = require("lint")

	-- specify linters per filetype
	lint.linters_by_ft = {
		lua = { "selene" },
		cmake = { "cmakelint" },
		html = { "markuplint" },
		css = { "stylelint" },
		go = { "golangcilint" },
	}

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
