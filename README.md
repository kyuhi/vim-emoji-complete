vim-emoji-complete
==================
A VIM plug-in for insert completion of emoji.
![vim-emoji-demo](http://i.imgur.com/FWPR9Ry.png)
How to use
----------
Press keys `<C-X><C-E>` in insert mode.

If you don't want it to overwrite standard key mappings, you can set your
favorite key mappings.
```vim
let g:emoji_complete_overwrite_standard_keymaps = 0
imap YOUR_FAVORITE_KEY_MAPPING <Plug>(emoji-start-complete)
```

LICENSE
-------
See LICENSE.

This plug-in use json data (emoji.json) taken from [gemoji](https://github.com/github/gemoji).
The project is licensed under the [LICENSE](https://github.com/github/gemoji/blob/master/LICENSE).

