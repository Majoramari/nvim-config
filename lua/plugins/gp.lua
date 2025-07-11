return {
	"robitx/gp.nvim",
	opts = {
		providers = {
			ollama = {
				disable = false,
				endpoint = "http://localhost:11434/v1/chat/completions",
			},
		},

		cmd_prefix = "Gp",
		log_file = vim.fn.stdpath("log"):gsub("/$", "") .. "/gp.nvim.log",
		log_sensitive = false,
		state_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/gp/persisted",
		default_command_agent = "Muhannad's assistant",
		default_chat_agent = "Muhannad's assistant",

		agents = {
			{
				provider = "ollama",
				name = "Muhannad's assistant",
				chat = true,
				command = true,
				model = {
					model = "codegemma:latest",
					temperature = 0.4,
					top_p = 1,
					min_p = 0.05,
				},
				system_prompt = "You are a general AI assistant.",
			},
		},

		hooks = {
			Implement = function(gp, params)
				local template = "Having following from {{filename}}:\n\n"
					.. "```{{filetype}}\n{{selection}}\n```\n\n"
					.. "Please rewrite this according to the contained instructions."
					.. "\n\nRespond exclusively with the snippet that should replace the selection above."

				local agent = gp.get_command_agent()
				gp.logger.info("Implementing selection with agent: " .. agent.name)

				gp.Prompt(params, gp.Target.rewrite, agent, template, nil, nil)
			end,

			UnitTests = function(gp, params)
				local template = "I have the following code from {{filename}}:\n\n"
					.. "```{{filetype}}\n{{selection}}\n```\n\n"
					.. "Please respond by writing table driven unit tests for the code above."
				local agent = gp.get_command_agent()
				gp.Prompt(params, gp.Target.vnew, agent, template)
			end,

			Explain = function(gp, params)
				local template = "I have the following code from {{filename}}:\n\n"
					.. "```{{filetype}}\n{{selection}}\n```\n\n"
					.. "Please respond by explaining the code above."
				local agent = gp.get_chat_agent()
				gp.Prompt(params, gp.Target.popup, agent, template)
			end,

			CodeReview = function(gp, params)
				local template = "I have the following code from {{filename}}:\n\n"
					.. "```{{filetype}}\n{{selection}}\n```\n\n"
					.. "Please analyze for code smells and suggest improvements."
				local agent = gp.get_chat_agent()
				gp.Prompt(params, gp.Target.enew("markdown"), agent, template)
			end,
		},
	},

	keys = {
		-- ===== Generation Hooks (n, i, v) =====
		{ "<C-g>gi", "<cmd>GpImplement<cr>", mode = { "n", "i", "v" }, desc = "Generate: implement" },
		{ "<C-g>gu", "<cmd>GpUnitTests<cr>", mode = { "n", "i", "v" }, desc = "Generate: unit tests" },
		{ "<C-g>ge", "<cmd>GpExplain<cr>", mode = { "n", "i", "v" }, desc = "Generate: explain" },
		{ "<C-g>gr", "<cmd>GpCodeReview<cr>", mode = { "n", "i", "v" }, desc = "Generate: code review" },

		-- ===== Visual Chat on Selection =====
		{ "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", mode = "v", desc = "Visual: Chat in new tab" },
		{ "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", mode = "v", desc = "Visual: Chat in vertical split" },
		{ "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", mode = "v", desc = "Visual: Chat in horizontal split" },
		{ "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", mode = "v", desc = "Visual: Append after selection" },
		{ "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", mode = "v", desc = "Visual: Prepend before selection" },
		{ "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", mode = "v", desc = "Visual: New chat for selection" },
		{ "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", mode = "v", desc = "Visual: Open GpEnew buffer" },
		{ "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", mode = "v", desc = "Visual: Open GpNew buffer" },
		{ "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", mode = "v", desc = "Visual: Show popup" },
		{ "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", mode = "v", desc = "Visual: New tab buffer" },
		{ "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", mode = "v", desc = "Visual: New vertical buffer" },
		{ "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", mode = "v", desc = "Visual: Implement selection" },

		-- ===== Inline Controls =====
		{ "<C-g>n", "<cmd>GpNextAgent<cr>", mode = { "n", "i", "v" }, desc = "Cycle to next agent" },
		{ "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", mode = "v", desc = "Visual: Paste last chat" },
		{ "<C-g>r", "<cmd>GpRewrite<cr>", mode = { "n", "v" }, desc = "Rewrite selection or line" },
		{ "<C-g>s", "<cmd>GpStop<cr>", mode = { "n", "i", "v" }, desc = "Stop ongoing request" },
		{ "<C-g>t", "<cmd>GpChatToggle<cr>", mode = { "n", "i", "v" }, desc = "Toggle chat interface" },
		{ "<C-g>x", "<cmd>GpContext<cr>", mode = { "n", "i", "v" }, desc = "Toggle context panel" },

		-- ===== New Chat (n, i) =====
		{ "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", mode = { "n", "i" }, desc = "Open chat in new tab" },
		{ "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", mode = { "n", "i" }, desc = "Open chat in vertical split" },
		{ "<C-g><C-x>", "<cmd>GpChatNew split<cr>", mode = { "n", "i" }, desc = "Open chat in horizontal split" },
		{ "<C-g>c", "<cmd>GpChatNew<cr>", mode = { "n", "i" }, desc = "Start new chat" },
		{ "<C-g>f", "<cmd>GpChatFinder<cr>", mode = { "n", "i" }, desc = "Find previous chats" },
		{ "<C-g>ge", "<cmd>GpEnew<cr>", mode = { "n", "i" }, desc = "Open empty GpEnew buffer" },
		{ "<C-g>gn", "<cmd>GpNew<cr>", mode = { "n", "i" }, desc = "Open new GpNew buffer" },
		{ "<C-g>gp", "<cmd>GpPopup<cr>", mode = { "n", "i" }, desc = "Show popup" },
		{ "<C-g>gt", "<cmd>GpTabnew<cr>", mode = { "n", "i" }, desc = "Open new tab buffer" },
		{ "<C-g>gv", "<cmd>GpVnew<cr>", mode = { "n", "i" }, desc = "Open new vertical buffer" },
	},
}
