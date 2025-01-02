local metals = {
	"scalameta/nvim-metals",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"mfussenegger/nvim-dap",
	},
	ft = { "scala", "sbt", "java" },
	opts = function()
		local metals_config = require("metals").bare_config()
		metals_config.on_attach = function(client, bufnr)
			require("metals").setup_dap()

			local dap = require("dap")
			dap.configurations.scala = {
				{
					type = "scala",
					request = "launch",
					name = "Run or Test Target",
					metals = {
						runType = "runOrTestFile",
					},
				},
				{
					type = "scala",
					request = "launch",
					name = "Test Target",
					metals = {
						runType = "testTarget",
					},
				},
			}

			vim.keymap.set("n", "<leader>mc", function()
				require("telescope").extensions.metals.commands()
			end)

			vim.keymap.set("n", "<leader>dc", function()
				require("dap").continue()
			end)
			vim.keymap.set("n", "<leader>dso", function()
				require("dap").step_over()
			end)
			vim.keymap.set("n", "<leader>dsi", function()
				require("dap").step_into()
			end)
			vim.keymap.set("n", "<leader>dst", function()
				require("dap").step_out()
			end)
			vim.keymap.set("n", "<Leader>db", function()
				require("dap").toggle_breakpoint()
			end)
			vim.keymap.set("n", "<Leader>lp", function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end)
			vim.keymap.set("n", "<Leader>dr", function()
				require("dap").repl.open()
			end)
			vim.keymap.set("n", "<Leader>dl", function()
				require("dap").run_last()
			end)
			vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
				require("dap.ui.widgets").hover()
			end)
			vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
				require("dap.ui.widgets").preview()
			end)
			vim.keymap.set("n", "<Leader>df", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end)
			vim.keymap.set("n", "<Leader>ds", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end)
		end

		metals_config.settings = {
			autoImportBuild = "all",
			-- testUserInterface = "Test Explorer",
		}
		return metals_config
	end,
	config = function(self, metals_config)
		local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = self.ft,
			callback = function()
				require("metals").initialize_or_attach(metals_config)
			end,
			group = nvim_metals_group,
		})
	end,
}

return { metals }
