local helpers = dofile("tests/helpers/init.lua")
local storage = require("themeui.storage")
local MiniTest = require("mini.test")

local child = helpers.new_child_neovim()
local T = child.setup()
local new_set, eq = MiniTest.new_set, MiniTest.expect.equality

T["storage"] = new_set()

T["storage"]["check if file_exist() works correctly"] = function()
	eq(storage.file_exist("nonexistentfile"), false)
	eq(storage.file_exist(helpers.tmp), true)
end

T["storage"]["check if correct path is returned"] = function()
	eq(storage.get_file_path(), helpers.tmp .. "/themes.json")
end

T["storage"]["check if state is stored and loaded correctly v2"] = function()
	local state = {
		themes = { "one", "two", "three" },
		index = 2,
		background = "light",
	}

	storage.save(state)
	local loaded = storage.load()

	eq(loaded.themes, state.themes)
	eq(loaded.index, state.index)
	eq(loaded.background, state.background)
end

return T
