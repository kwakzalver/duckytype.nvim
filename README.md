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

**NOTE** when you override a non-existing key it will error

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

**NOTE** Feel free to add keywords in a pull request.

#
