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

T["setup"]["applies correct theme on startup"] = function()
	child.lua(
		-- [[ require("themeui").storage.save(vim.json.encode( {"themes":["one","two","three"],"background":"dark","index":3}) }) ]]
		[[
      require('themeui')
    ]]
	)
	child.lua([[
    M.setup({
      state = {
        index = 1,
        themes = { "one", "two", "three" },
        background = "light"
      }
    })
  ]])

	local theme = child.lua_get([[ M.config.state.themes[2] ]])
	eq(theme, "two")
end

return T
