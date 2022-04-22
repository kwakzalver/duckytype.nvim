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
}

return Defaults
