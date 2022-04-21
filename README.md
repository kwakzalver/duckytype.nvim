# DuckyType.nvim

Like MonkeyType, but avian. 🦆

In your lua configuration, add the setup for the defaults.
```lua
require('duckytype').setup{}
```

By default, the expected words are randomly sampled from `english_common`.
See `constants.lua` file for other sets of keywords.

Then bind a key to
```lua
require('duckytype').Start()
```

#
