local keybinds = require("themeui.keybinds")

local M = {}

M.config = require("themeui.config")

local defaults = {
	keymaps = {
		toggle_background = "<leader>bg",
		switch_theme = "<leader>ts",
		theme_selector = "<leader>th",
	},
}

function M.setup(users)
	users = users or {}
	M.config = vim.tbl_deep_extend("force", defaults, users)
	keybinds.set_keys(M.config.keymaps)
end

return M
