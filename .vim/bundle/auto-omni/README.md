# Auto Omnicompletion

## Instalation

### [vim-plug](https://github.com/junegunn/vim-plug)
```viml
Plug 'BrandonRoehl/auto-omni'
```
### [Vundle.vim](https://github.com/VundleVim/Vundle.vim)
```viml
Plugin 'BrandonRoehl/auto-omni'
```
### [vim-pathogen](https://github.com/tpope/vim-pathogen)
```bash
git clone https://github.com/BrandonRoehl/auto-omni.git ~/.vim/bundle/auto-omni
```

## Configuration

This plugin does exactly that.

inspired by [AutoComplPop](https://vim.sourceforge.io/scripts/script.php?script_id=1879)
this plugin will just pop open the omni completion menu in standard vim on key
press if the `omnifunc` is set for that filetype

First just add the plugin to your vimrc

```viml
filetype plugin on

" Enable omni for all types and auto set it
" [Recomended]
set omnifunc=syntaxcomplete#Complete

" Enable omni completion per file.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
```

```viml
" Then set the how the popup behaves
" this plugin sets the default behavior to
set completeopt=noinsert,menuone
" I suggest leaving the noinsert option set otherwise
" the plugin will always insert the first item in the popup
```

You can manually set the keys that trigger the completion by default all
alpha keys will trigger it
```viml
# Default keys
let g:auto_omnicomplete_key =
            \ 'a b c d e f g h i j k l m n o p q r s t u v w x y z ' .
            \ 'A B C D E F G H I J K L M N O P Q R S T U V W X Y Z'
```

## My Setup
```viml
set omnifunc=syntaxcomplete#Complete
set completeopt=noinsert,menuone
let g:rubycomplete_buffer_loading=1
let g:rubycomplete_classes_in_global=1
let g:rubycomplete_rails=0
let g:loaded_sql_completion=0
let g:omni_sql_no_default_maps=1
```

