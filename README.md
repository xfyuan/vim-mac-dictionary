# vim-mac-dictionary

A Vim plugin that helps you find words using Mac's dictionary app.

![vim-mac-dict-plugin-demo](https://cdn.jsdelivr.net/gh/xfyuan/ossimgs@master/20200714vim-mac-dict-plugin-demo.gif)

# Installation

* This plug-in is only available for macOS.
* **Notes: the popup feature depends on [vim-quickui](https://github.com/skywind3000/vim-quickui) plugin**.

## VimPlug

Place this in your .vimrc:

```viml
Plug 'skywind3000/vim-quickui'
Plug 'xfyuan/vim-mac-dictionary'
```

Then

```
:PlugInstall
```

## Select a dictionary to use

1. Launch the built-in dictionary app on your Mac.
2. Enter `command +,` to enter the setting screen.
3. Drag the mouse over the dictionary you want to use and put it on the **top line**.
    * Please be sure to set it because it will show only the search result of the dictionary in the top row.

![setting](https://user-images.githubusercontent.com/1855714/48071044-a4676000-e21c-11e8-8609-a8c33b58e28c.png )

![setting](https://user-images.githubusercontent.com/1855714/48068975-89462180-e217-11e8-9f01-a7d58ba690d8.png )

## How To Use

* Place the cursor on a word and type `:MacDictPopup` to find the dictionary, and print result in floating window. 
* Place the cursor on a word and type `:MacDictWord` to find the dictionary, and print result in a new buffer.
* type `:MacDictQuery` and then type the word you want to search for, it will find the dictionary.

You can register shortcuts in the following ways:

```viml
nnoremap <silent><leader>ww :MacDictPopup<CR>
nnoremap <silent><leader>wd :MacDictWord<CR>
nnoremap <silent><leader>wq :MacDictQuery<CR>
```

## Configuration

### Do not using formatted result

```viml
" shows the raw string from the dictionary
let g:vim_mac_dictionary_use_format = 0
```

### View in app

```viml
let g:vim_mac_dictionary_use_app = 1
```
