# Run all test files
test: deps
	@nvim --headless --noplugin -u ./scripts/minimal_init.lua -c "lua MiniTest.run()"

# Run test from file at `$FILE` environment variable
test_file: deps/mini.nvim
	@nvim --headless --noplugin -u ./scripts/minimal_init.lua -c "lua MiniTest.run_file('$(FILE)')"

# Download 'mini.nvim' to use its 'mini.test' testing module
# Download 'nui.nvim' to use its 'nui.menu' module
deps:
	@mkdir -p deps
	@git clone --filter=blob:none https://github.com/MunifTanjim/nui.nvim $@
	@git clone --filter=blob:none https://github.com/nvim-mini/mini.nvim $@

# Run sanity_check to make sure the plugin loads correctly
sanity_check:
	@nvim --headless -u scripts/minimal_init.lua +'lua print(vim.inspect(pcall(require,"themeui")))' +q
