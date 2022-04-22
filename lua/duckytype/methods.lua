local settings = require('duckytype.settings')
local constants = require('duckytype.constants')

local buffer
local window
local started
local finished
local expected = nil

local namespace = vim.api.nvim_create_namespace("DuckyType.nvim")

local Methods = {}

local function Expect(key, T)
  v = T[key]
  if v == nil then
    error("no " .. key .. "?")
  end
  return v
end

local function Print(structure, prefix)
  prefix = prefix or "X"
  local s_type = type(structure)
  if (s_type ~= "table") then
    print(prefix .. " = " .. structure .. " (" .. s_type .. ")")
    return
  end
  print(prefix .. " (" .. s_type .. ")")
  for k, v in pairs(structure) do
    Print(v, prefix .. "[" .. tostring(k) .. "]")
  end
end

local function Update(T, U)
  if type(T) ~= "table" or type(U) ~= "table" then
    Print(T, "defaults")
    Print(U, "update")
    error("Invalid types given in Update(T, U) (see above)!")
  end
  for k, v in pairs(U) do
    c = T[k]
    if c == nil then
      Print(U)
      error("Update was unsuccessful, because key «" .. tostring(k) .. "» is invalid!")
    end
    if type(c) == "table" then
      Update(c, v)
    else
      T[k] = v
    end
  end
end

Methods.Start = function(key_override)
  local key = key_override or settings.expected
  local lookup_table = Expect(key, constants)

  buffer = vim.api.nvim_create_buf(false, true)
  window = vim.api.nvim_open_win(buffer, true, settings.window_config)

  expected = {}
  -- fill expected with random words from lookup_table
  local line = {}
  local line_width = 0
  math.randomseed(os.time())
  for i=0,settings.number_of_words do
    local random = lookup_table[math.ceil(math.random() * #lookup_table)]
    line_width = line_width + #random + 1
    if line_width >= settings.window_config.width then
      -- line overflow, start a new line
      local line_text = string.format("%s ", table.concat(line, " "))
      table.insert(expected, line_text)
      line = {}
      line_width = #random
    end
    table.insert(line, random)
  end

  -- remove the last trailing space from expected lines
  local lastline = expected[#expected]
  expected[#expected] = string.sub(lastline, 1, #lastline - 1)

  -- pad the current buffer with some empty strings, so the virtual text
  -- highlighting shows. and +3 more just for good measure.
  local empty = { "", "", "" }
  for _, _ in ipairs(expected) do
    table.insert(empty, "")
  end
  vim.api.nvim_buf_set_lines(buffer, 0, #empty + 1, false, empty)

  -- local events = {}
  vim.api.nvim_buf_attach(buffer, false, {
    on_lines = function(...)
      -- table.insert(events, {...})
      -- NOTE terribly inefficient
      -- TODO parse changes here instead so we don't re-fill the entire buffer
      -- on every single keystroke. check `nvim_buf_attach` documentation
      local done = Methods.RedrawBuffer()
      if done then
        if finished == nil then
          finished = os.time()
        end
        local elapsed = finished - started
        local total = 0
        for _, line in ipairs(expected) do
          total = total + #line
        end
        local wpm_estimate = (total / settings.average_word_length) / (elapsed / 60.0)
        local message = string.format(
        "you typed %d characters in %d seconds, that is roughly %d wpm!",
        total, elapsed, wpm_estimate)
        Methods.HighlightLine(buffer, #expected, ":: ", message)
        Methods.RedrawBuffer()
      end
    end
  })

  -- TODO fix the entire mess below, currently the virtual text is redrawn in
  -- full every keystroke, and things that result in a new newline are hardwired
  -- to redraw just to not have the virtual text shuffle back and forth

  -- TODO make a InsertEnter autocmd instead of these two ugly workarounds (?)
  local kmopts = { noremap = true, silent = true }
  local km = function(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, kmopts)
  end
  km('i',
    [[<CR>]],
    [[<CR><Esc>:lua require('duckytype').RedrawBuffer()<CR>i]]
  )
  km('n',
    [[o]],
    [[o<Esc>:lua require('duckytype').RedrawBuffer()<CR>i]]
  )

  Methods.RedrawBuffer()

  -- TODO proper timing, starts on first keystroke instead of when window shows
  started = os.time()
  finished = nil

  -- TODO enter the new buffer on insert mode more idiomatically
  vim.api.nvim_input('i')
end

Methods.Setup = function(update)
  update = update or {}
  Update(settings, update)
end

local function StartsWith(s, prefix)
  return s:find(prefix, 1, true) == 1
end

local function LongestPrefixLength(s, prefix)
  -- NOTE terribly inefficient
  -- TODO this should be done linear, not quadratic
  -- how to iterate over a string?
  if StartsWith(s, prefix) then
    return #prefix
  end
  if not StartsWith(s, string.sub(prefix, 1, 1)) then
    return 0
  end
  local length = 2
  while StartsWith(s, string.sub(prefix, 1, length)) do
    length = length + 1
  end
  return length - 1
end

Methods.HighlightLine = function(buffer, line_index, line, prefix)
  local length = LongestPrefixLength(line, prefix)
  local good = string.sub(line, 1, length)
  local bad = string.sub(line, length + 1)
  local remaining = string.sub(prefix, length + 1)
  local column = length
  local opts = {
    id = line_index + 1,
    virt_text = {
      { good, "Todo"},
      { bad, "Error" },
      { remaining, "Type"},
    },
    virt_text_pos = "overlay",
  }
  local id = vim.api.nvim_buf_set_extmark(buffer, namespace, line_index, 0, opts)
  return #remaining == 0
end

Methods.RedrawBuffer = function()
  local line_index_start = 1
  local line_index_end = #expected + 1
  local lines = vim.api.nvim_buf_get_lines(buffer, 0, line_index_end + 1, false)

  local done = true
  local offset = 0
  while line_index_start + offset < line_index_end do
    local line = lines[offset + 1]
    if line == nil then return false end
    local prefix = expected[offset + 1]
    if prefix == nil then return done end
    local okay = Methods.HighlightLine(buffer, offset, line, prefix)
    done = done and okay
    local cursor = vim.api.nvim_win_get_cursor(window)
    local row = cursor[1]
    if okay and row - 1 == offset then
      vim.api.nvim_win_set_cursor(window, { row + 1 , 0 })
    end
    offset = offset + 1
  end
  return done
end

return Methods
