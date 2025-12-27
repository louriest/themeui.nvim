local store = require("themeui.store")
local helpers = require("themeui.helpers")
local selector = require("themeui.select")

--- @class ThemeUICommands
--- @field setup fun(config: ThemeUIConfig)
local commands = {}

--- @param config ThemeUIConfig
function commands.setup(config)
	vim.api.nvim_create_user_command("ThemeUINext", function()
		store.next(config.state)
	end, { desc = "Switch to next theme" })

	vim.api.nvim_create_user_command("ThemeUIPrev", function()
		store.prev(config.state)
	end, { desc = "Switch to previous theme" })

	vim.api.nvim_create_user_command("ThemeUIToggleBackground", function()
		store.toggle_background(config.state)
	end, { desc = "Toggle background mode" })

	vim.api.nvim_create_user_command("ThemeUISaveFile", function()
		helpers.get_file_path()
	end, { desc = "Returns state path for the current buffer." })

	vim.api.nvim_create_user_command("ThemeUIState", function()
		local s = helpers.load()
		vim.notify(vim.json.encode({
			colorscheme = s.themes[s.index],
			background = s.background,
		}))
	end, { desc = "Returns state path for the current buffer." })

	vim.api.nvim_create_user_command("ThemeUISelect", function()
		selector.setup(config)
	end, { desc = "Open a select menu to select a theme." })
end

return commands
