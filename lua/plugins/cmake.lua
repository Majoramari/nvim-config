return {
	"Civitasv/cmake-tools.nvim",
	ft = { "c", "cpp", "cmake", "CMakeLists.txt" },
	config = function()
		local osys = require("cmake-tools.osys")
		require("cmake-tools").setup({
			cmake_command = "cmake",
			ctest_command = "ctest",
			cmake_use_preset = true,
			cmake_regenerate_on_save = true,
			cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
			cmake_build_options = {},
			-- CMake build directory with macro expansion
			cmake_build_directory = function()
				if osys.iswin32 then
					return ".out\\${variant:buildType}"
				end
				return ".out/${variant:buildType}"
			end,
			cmake_soft_link_compile_commands = true,
			cmake_compile_commands_from_lsp = false,
			cmake_kits_path = nil,
			cmake_variants_message = {
				short = { show = true },
				long = { show = true, max_length = 40 },
			},
			cmake_dap_configuration = {
				name = "cpp",
				type = "codelldb",
				request = "launch",
				stopOnEntry = false,
				runInTerminal = true,
				console = "integratedTerminal",
			},
			cmake_executor = {
				name = "quickfix",
				opts = {},
				default_opts = {
					quickfix = {
						show = "always",
						position = "belowright",
						size = 10,
						auto_close_when_success = true,
					},
				},
			},
			cmake_runner = {
				name = "toggleterm",
				opts = {},
				default_opts = {
					toggleterm = {
						direction = "float",
						close_on_exit = false,
						auto_scroll = true,
						singleton = true,
					},
				},
			},
			cmake_notifications = {
				runner = { enabled = false },
				executor = { enabled = false },
			},
			cmake_virtual_text_support = true,
		})
	end,
}
