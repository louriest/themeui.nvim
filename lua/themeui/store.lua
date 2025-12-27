local engine = require("themeui.engine")

--- @class ThemeUIStore
--- @field new fun(state: ThemeUIState): ThemeUIState
--- @field list_themes fun(state: ThemeUIState): string[]
--- @field next fun(state: ThemeUIState)
--- @field prev fun(state: ThemeUIState)
--- @field toggle_background fun(state: ThemeUIState)
local store = {}

--- @param state ThemeUIState
--- @return ThemeUIState
function store.new(state)
	local updated_state = {
		themes = state.themes or {},
		index = state.index or 1,
		background = state.background or "dark",
	}
	return updated_state
end

--- @param state ThemeUIState
function store.list_themes(state)
	return state.themes
end

--- @param state ThemeUIState
function store.next(state)
	local i = state.index + 1
	if i > #state.themes then
		i = 1
	end
	state.index = i
	engine.apply_theme(state)
end

--- @param state ThemeUIState
function store.prev(state)
	local i = state.index - 1
	if i < 1 then
		i = #state.themes
	end
	state.index = i
	engine.apply_theme(state)
end

--- @param state ThemeUIState
function store.toggle_background(state)
	state.background = (state.background == "light") and "dark" or "light"
	engine.apply_background(state)
end

return store
