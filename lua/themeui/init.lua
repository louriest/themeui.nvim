local keybinds = require("themeui.keybinds")
local data = require("themeui.data")
local config = require("themeui.config")

local M = {}

M.config = config

local defaults = {
	keymaps = {
		toggle_background = "<leader>bg",
		switch_theme = "<leader>ts",
		theme_selector = "<leader>th",
	},
}

local function setup_themes(users)
	-- Disable keymaps if no themes are available
	if not users or not users.themes or vim.tbl_count(users.themes) == 0 then
		return
	end

	keybinds.set_keys(M.config.keymaps)
	data.update_themes(M.config.themes)
end

function M.setup(users)
	users = users or {}
	M.config = vim.tbl_deep_extend("force", defaults, users)
	setup_themes(users)
end

return M
