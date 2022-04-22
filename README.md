# DuckyType.nvim

Like MonkeyType, but avian. 🦆

In your lua configuration, add the setup for the defaults.
```lua
require('duckytype').setup{
  expected = "english_common",
  number_of_words = 50,
}
```

By default, the expected words are randomly sampled from `english_common`.
See `constants.lua` file for other sets of keywords.
The default source can be edited in the setup, but it could also be passed as a
key argument to the `Start` function, so there is no need to reload vim if you
want to to have a Go at go keywords.

Then bind a key to
```lua
require('duckytype').Start('go_keywords')
```

#
