" VimCompletesMe.vim - Super simple tab completion
" Maintainer:          Akshay Hegde <http://github.com/ackyshake>
" Version:             1.5.2
" Website:             <http://github.com/ackyshake/VimCompletesMe>

" Vimscript Setup: {{{1
if exists("g:loaded_VimCompletesMe") || v:version < 703 || &compatible
  finish
endif
let g:loaded_VimCompletesMe = 1

" Options: {{{1
if !exists('g:vcm_s_tab_behavior')
  let g:vcm_s_tab_behavior = 0
endif
if !exists('g:vcm_direction')
  let g:vcm_direction = 'n'
endif
if !exists('g:vcm_default_maps')
  let g:vcm_default_maps = 1
endif
if !exists('g:vcm_omni_pattern')
  let g:vcm_omni_pattern = '\k\+\(\.\|->\|::\)\k*$'
endif

" Maps: {{{1
inoremap <expr> <plug>vim_completes_me_forward  VimCompletesMe#vim_completes_me(0)
inoremap <expr> <plug>vim_completes_me_backward VimCompletesMe#vim_completes_me(1)
if g:vcm_default_maps
  imap <Tab>   <plug>vim_completes_me_forward
  imap <S-Tab> <plug>vim_completes_me_backward
endif

" Autocmds {{{1
augroup VCM
  autocmd!
  autocmd InsertEnter * let b:completion_tried = 0
  if v:version > 703 || v:version == 703 && has('patch598')
    autocmd CompleteDone * let b:completion_tried = 0
  endif
augroup END
