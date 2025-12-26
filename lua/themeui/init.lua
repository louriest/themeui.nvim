local keybinds = require("themeui.keybinds")
local data = require("themeui.data")
local api = require("themeui.api")
local persistence = require("themeui.persistence")

--- @class themeui
--- @field config table Configuration table
local M = {}

M.config = api

local defaults = {
	keymaps = {
		toggle_background = "<leader>bg",
		switch_theme = "<leader>ts",
		theme_selector = "<leader>th",
	},
}

--- Configure themeui plugin and set keybinds
--- @param users table User configuration
local function setup_themes(users)
	-- Disable keymaps if no themes are available
	if not users or not users.themes or vim.tbl_count(users.themes) == 0 then
		return
	end

	keybinds.set_keys(M.config.keymaps)
	data.update_themes(M.config.themes)
end

--- setup themeui plugin
--- @param users table User configuration
function M.setup(users)
	users = users or {}
	M.config = vim.tbl_deep_extend("force", defaults, users)
	setup_themes(users)
	vim.api.nvim_create_autocmd("VimEnter", {
		once = true,
		callback = function()
			persistence.load_preferences()
		end,
	})
end

return M
