local Defaults = {
  expected = "english_common",
  number_of_words = 50,
  -- assuming an average word is 5.8 characters long - guesstimate which is
  -- based on the average length of the english top 1000 common words,
  -- MonkeyType uses 5, so if you want higher scores to stroke your ego...
  average_word_length = 5.8,

  -- centered adjusts col and row of window config when a new game starts
  centered = true,
  window_config = {
    style = 'minimal',
    border = 'single',
    relative = 'editor',
    focusable = true,
    col = 1,
    row = 1,
    width = 69,
    height = 8,
  },

  -- link correct/incorrect/remaining to highlighting groups
  highlight = {
    good = "Todo",
    bad = "Error",
    remaining = "Function",
  },
}

return Defaults
