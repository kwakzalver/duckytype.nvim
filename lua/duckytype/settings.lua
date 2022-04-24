-- local border = {
--     { "┏", "FloatBorder" },
--     { "━", "FloatBorder" },
--     { "┓", "FloatBorder" },
--     { "┃", "FloatBorder" },
--     { "┛", "FloatBorder" },
--     { "━", "FloatBorder" },
--     { "┗", "FloatBorder" },
--     { "┃", "FloatBorder" },
-- }

-- local border = {
-- 	{ "╔", "FloatBorder" },
-- 	{ "═", "FloatBorder" },
-- 	{ "╗", "FloatBorder" },
-- 	{ "║", "FloatBorder" },
-- 	{ "╝", "FloatBorder" },
-- 	{ "═", "FloatBorder" },
-- 	{ "╚", "FloatBorder" },
-- 	{ "║", "FloatBorder" },
-- }

local border = {
	{ "╭", "CmpBorder" },
	{ "─", "CmpBorder" },
	{ "╮", "CmpBorder" },
	{ "│", "CmpBorder" },
	{ "╯", "CmpBorder" },
	{ "─", "CmpBorder" },
	{ "╰", "CmpBorder" },
	{ "│", "CmpBorder" },
}

local Defaults = {
	expected = "english_common",
	number_of_words = 50,
	-- assuming an average word is 5.8 characters long - guesstimate which is
	-- based on the average length of the english top 1000 common words,
	-- MonkeyType uses 5, so if you want higher scores to stroke your ego...
	average_word_length = 5.8,

	-- maybe the little pop-up window looks better when centered instead
	window_config = {
		style = "minimal",
		border = border,
		relative = "win",
		focusable = true,
		col = 1,
		row = 1,
		width = 80,
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
