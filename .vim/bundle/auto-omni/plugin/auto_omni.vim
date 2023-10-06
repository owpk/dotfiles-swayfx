"---------- OmniComplete on keypress ----------"

if exists("g:loaded_auto_omni")
  finish
endif
let g:loaded_auto_omni=1

" Keys that trigger completeopt
if !exists("g:auto_omni_key")
    let g:auto_omni_key = '. : @'
endif

" On read or new make if we have omnifunc available
" then load and initialize the plugin
autocmd BufNewFile,BufRead * call AutoOmniBind()
function! AutoOmniBind()
    if exists('&omnifunc') && &omnifunc != ""
        call auto_omni#bind()
    endif
endfunction
command! -nargs=0 -bar AutoOmniLock
      \ call auto_omni#_lock()
command! -nargs=0 -bar AutoOmniUnlock
      \ call auto_omni#_unlock()

set completeopt=noinsert,menuone

