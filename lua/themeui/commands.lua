local store = require("themeui.store")
local storage = require("themeui.storage")
local selector = require("themeui.select")

--- @class ThemeUICommands
--- @field setup fun(config: ThemeUIConfig)
local commands = {}

--- @param config ThemeUIConfig
function commands.setup(config)
	vim.api.nvim_create_user_command("ThemeUINext", function()
		store.next(config.state)
		local theme = config.state.themes[config.state.index]
		vim.notify("Applying " .. theme .. " colorscheme", vim.log.levels.INFO, {})
	end, { desc = "Switch to next theme" })

	vim.api.nvim_create_user_command("ThemeUIPrev", function()
		store.prev(config.state)
		local theme = config.state.themes[config.state.index]
		vim.notify("Applying " .. theme .. " colorscheme", vim.log.levels.INFO, {})
	end, { desc = "Switch to previous theme" })

	vim.api.nvim_create_user_command("ThemeUIToggleBackground", function()
		if config.state.themes[config.state.index] == "dracula" then
			vim.notify("Dracula does not support light background")
			return
		end
		store.toggle_background(config.state)
		vim.notify("Switched to " .. config.state.background .. " mode", vim.log.levels.INFO, {})
	end, { desc = "Toggle background mode" })

	vim.api.nvim_create_user_command("ThemeUIState", function()
		local s = storage.load()
		vim.notify(vim.json.encode({
			{ colorscheme = s.themes[s.index] },
			{ background = s.background },
		}))
	end, { desc = "Returns state path for the current buffer." })

	vim.api.nvim_create_user_command("ThemeUISelect", function()
		selector.setup(config)
	end, { desc = "Open a select menu to select a theme." })
end

return commands
