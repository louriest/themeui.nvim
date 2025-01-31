--- @class data
--- @field themes string[] list of available themes
local M = {}

M.themes = {}

--- Returns list of available themes
--- @return string[] M.themes List of available themes
function M.get_themes()
	return M.themes
end

--- Updates list of available themes
--- @param themes string[] List of available themes
function M.update_themes(themes)
	for _, theme in ipairs(themes) do
		table.insert(M.themes, theme)
	end
end

return M
