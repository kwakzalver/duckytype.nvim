local constants = require('duckytype.constants')

local Defaults = {
  expected = "english_common",
  number_of_words = 50,
  -- maybe the little pop-up window looks better when centered instead
  window_config = {
    style = 'minimal',
    border = 'single',
    relative = 'win',
    focusable = true,
    col = 1,
    row = 1,
    width = 80,
    height = 8,
  },

  cpp_keywords = constants.cpp_keywords,
  go_keywords = constants.go_keywords,
  lua_keywords = constants.lua_keywords,
  python_keywords = constants.python_keywords,
  rust_keywords = constants.rust_keywords,

  english_common = constants.english_common,
}

return Defaults
