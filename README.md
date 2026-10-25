## install

Needs Vim 8.2.+ with `+popupwin`

```sh
mkdir -p ~/.vim/pack/plugins/start
git clone https://github.com/levk-m/vcp.git ~/.vim/pack/plugins/start/vcp
```

Help tags are optional:

```sh
vim -u NONE -c 'helptags ~/.vim/pack/plugins/start/vcp/doc' -c q
```

With vim-plug:

```vim
Plug 'levk-m/vcp'
```

## config

Point the plugin to your templates:

```vim
let g:vcp_dir = expand('~/.vim/cp_templates')
```

If you don't set it, the `templates/` folder inside the plugin is used.

Two more options:

```vim
let g:vcp_no_mappings = 1   " keep <C-t> free
let g:vcp_height = 15       " max popup height
```

## Use

Press `<C-t>` or run `:Vcp`, pick a template and hit Enter.

It fills an empty buffer, otherwise inserts below the current line.

Any readable file in `g:vcp_dir` becomes a template. Hidden files and folders
are skipped.
