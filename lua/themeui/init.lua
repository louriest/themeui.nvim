local commands = require("themeui.commands")
local store = require("themeui.store")
local keymaps = require("themeui.keymaps")
local storage = require("themeui.storage")
local engine = require("themeui.engine")

--- @class ThemeUIState
--- @field themes string[] List of available themes
--- @field index number
--- @field background "dark" | "light"

--- @class ThemeUIConfig
--- @field state ThemeUIState state of the plugin

--- @class keymaps
--- @field mode `n` | `v` | `i`
--- @field key string
--- @field cmd string
--- @field desc string

--- @class ThemeUI
--- @field config ThemeUIConfig
--- @field setup fun(config: ThemeUIConfig)
local themeui = {}

--- @type ThemeUIState
local state = {
	themes = {},
	index = 1,
	background = "dark",
}

--- @param config ThemeUIConfig config
function themeui.setup(config)
	config = config or {}

	themeui.config = {
		state = store.new(config.state or state),
	}

	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			local success, s = pcall(storage.load)
			if not success or type(s) ~= "table" then
				return
			end

			local st = themeui.config.state

			if s.index then
				st.index = s.index
			end

			if s.background then
				st.background = s.background
			end

			pcall(engine.apply_theme, st)
			pcall(engine.apply_background, st)
		end,
	})

	commands.setup(themeui.config)
	keymaps.setup()
end

return themeui
