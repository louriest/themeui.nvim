local helpers = dofile("tests/helpers/init.lua")
local MiniTest = require("mini.test")

local child = helpers.new_child_neovim()
local T = child.setup()
local new_set, eq = MiniTest.new_set, MiniTest.expect.equality

T["setup"] = new_set()

T["setup"]["applies default state"] = function()
	child.lua([[ M.setup() ]])

	local background = child.lua_get([[ M.config.state.background ]])
	local index = child.lua_get([[ M.config.state.index ]])
	local themes = child.lua_get([[ M.config.state.themes ]])

	eq(background, "dark")
	eq(index, 1)
	eq(themes, {})
end

T["setup"]["applies custom state"] = function()
	child.lua([[
    M.setup({
      state = {
        index = 2,
        themes = { "one", "two", "three" },
        background = "light"
      }
    })
  ]])

	local background = child.lua_get([[ M.config.state.background ]])
	local index = child.lua_get([[ M.config.state.index ]])
	local themes = child.lua_get([[ M.config.state.themes ]])

	eq(background, "light")
	eq(index, 2)
	eq(themes, { "one", "two", "three" })
end

return T
