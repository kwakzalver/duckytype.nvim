# DuckyType.nvim

Like MonkeyType, but avian. 🦆

In your lua configuration, add an empty setup to accept the defaults.

```lua
require('duckytype').setup{}
```

Then start with

```lua
require('duckytype').Start()
```

[duckytype](https://user-images.githubusercontent.com/104157438/164890512-a82ed072-d9ff-451c-8bfe-47a292486759.mov)

When a game is finished, the user can hit `Enter` in normal mode to start a new
game. Normal mode is entered automatically. The little window behaves just like
any other window, you can use `:q` to close it.

## Settings

By default, the expected words are randomly sampled from `english_common`.
See the [constants.lua](lua/duckytype/constants.lua) file for other sets of
keywords.

We can then override the defaults with

```lua
require('duckytype').setup{
  expected = "python_keywords",
  number_of_words = 42,
  average_word_length = 5.69,
}
```

**NOTE** When you override a non-existing key it will error

The keywords source can be edited in the setup, but it could also be passed as
an argument to the `Start` function, so there is no need to reload vim if you
want to to have a Go at go keywords.

Bind some keys to your favorite sets of keywords so you can waste your time
more efficiently.

```vim
require('duckytype').Start("english_common")
require('duckytype').Start("cpp_keywords")
require('duckytype').Start("python_keywords")
require('duckytype').Start("go_keywords")
```

### Potentially lesser known settings (but default for neovim)

The `nvim_open_win` `{config}` parameter can be overridden in the `setup`.
Where its key is named `window_config`. Use `:h nvim_open_win` in neovim to see
what kind of window customizations there are by default.

For instance, you could have the setup load a random border each time by having
the following setup in your lua configuration.

```lua
local borders = { "none", "single", "double", "rounded", "solid", "shadow" }
math.randomseed(os.time())
require('duckytype').setup{
  number_of_words = 10,
  window_config = {
    border = borders[math.ceil(math.random() * #borders)]
  },
}
```

The highlighting for correctly typed, incorrectly typed, and remaining texts
are also exposed by the setup. They could be linked to other highlighting
groups if you prefer different colors.

Usually the `Comment` highlighting group makes text stand out quite a bit less,
so if you want the correctly typed words to just kind of _vanish_, you could
link good to `Comment` like in the following setup.

```lua
require('duckytype').setup{
  number_of_words = 10,
  highlight = {
    good = "Comment",
    bad = "Error",
    remaining = "Todo",
  },
}
```

Check out the default syntax highlighting groups with `:h group-name` in
neovim.

## Contribute?

Feel free to make an issue for anything that's on your mind.

#
