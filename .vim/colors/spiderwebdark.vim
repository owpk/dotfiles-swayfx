"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File: spiderwebdark.vim
" Created: Fri, 06 Feb 2009 17:50:06 +0100
" Updated: Fri, 06 Feb 2009 17:50:12 +0100
" Copyright (C) 2009, Danilo Dellaquila <ddellaquila@gmail.com>
" Based on "dante.vim" colorscheme by Caciano Machado
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  16-color iand 8-color terminals reference
"
"	    NR-16   NR-8    COLOR NAME
"	    0	    0	    Black
"	    1	    4	    DarkBlue
"	    2	    2	    DarkGreen
"	    3	    6	    DarkCyan
"	    4	    1	    DarkRed
"	    5	    5	    DarkMagenta
"	    6	    3	    Brown, DarkYellow
"	    7	    7	    LightGray, LightGrey, Gray, Grey
"	    8	    0*	    DarkGray, DarkGrey
"	    9	    4*	    Blue, LightBlue
"	    10	    2*	    Green, LightGreen
"	    11	    6*	    Cyan, LightCyan
"	    12	    1*	    Red, LightRed
"	    13	    5*	    Magenta, LightMagenta
"	    14	    3*	    Yellow, LightYellow
"	    15	    7*	    White
"
" Colorscheme Option:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi clear
if exists("syntax on")
    syntax reset
endif
let g:colors_name = "spiderwebdark"
set background=dark

" Customized colors
hi Normal   ctermfg=white guifg=white guibg=black
hi LineNr   term=underline ctermfg=yellow guifg=yellow guibg=gray4
hi CursorLine   term=reverse cterm=reverse gui=reverse guifg=white
hi CursorColumn   term=reverse cterm=reverse gui=reverse guifg=white

" General colors
"hi Normal   ctermfg=gray guifg=peachpuff3 guibg=black
hi Directory    term=bold ctermfg=blue guifg=royalblue
hi ErrorMsg term=standout ctermfg=white ctermbg=red guifg=white guibg=red3
hi NonText  term=bold ctermfg=darkgray guibg=gray3 guifg=gray20
hi SpecialKey   term=bold ctermfg=darkgray guifg=gray30
"hi LineNr   term=underline ctermfg=darkgray guifg=ivory4 guibg=gray4
hi IncSearch    term=reverse cterm=reverse gui=reverse,bold guifg=darkgoldenrod2
hi Search   term=reverse ctermfg=black ctermbg=yellow guifg=gray10 guibg=gold2
hi Visual   term=bold,reverse cterm=bold,reverse ctermfg=gray ctermbg=black gui=bold,reverse guifg=gray40 guibg=black
hi VisualNOS    term=bold,underline cterm=bold,underline gui=bold,underline
hi MoreMsg  term=bold ctermfg=green gui=bold guifg=olivedrab1
hi ModeMsg  term=bold cterm=bold gui=bold
hi Question term=standout ctermfg=green gui=bold guifg=olivedrab1
hi WarningMsg   term=standout ctermfg=red gui=bold guifg=red3
hi WildMenu term=standout ctermfg=black ctermbg=yellow guifg=black guibg=gold2
hi Folded   term=standout ctermfg=blue ctermbg=white guifg=royalblue1 guibg=white
hi FoldColumn   term=standout ctermfg=blue ctermbg=white guifg=royalblue3 guibg=white
hi DiffAdd  term=bold ctermbg=blue guibg=royalblue2
hi DiffChange   term=bold ctermbg=darkmagenta guibg=maroon
hi DiffDelete   term=bold cterm=bold ctermfg=lightblue ctermbg=cyan gui=bold guifg=lightblue guibg=cyan4
hi DiffText term=reverse cterm=bold ctermbg=red gui=bold guibg=red3
hi Cursor   guifg=bg guibg=fg
hi lCursor  guifg=bg guibg=fg
hi StatusLine   term=reverse cterm=reverse gui=reverse guifg=gray60
hi StatusLineNC term=reverse cterm=reverse gui=reverse guifg=gray40
hi VertSplit    term=reverse cterm=reverse gui=bold,reverse guifg=gray40
hi Title    term=bold ctermfg=magenta gui=bold guifg=aquamarine

" syntax hi colors
hi Comment  term=bold ctermfg=darkcyan guifg=cyan4
hi PreProc  term=underline ctermfg=darkgreen guifg=dodgerblue4
hi Constant term=underline ctermfg=darkred guifg=firebrick3
hi Type     term=underline ctermfg=darkgreen gui=none guifg=chartreuse3
hi Statement    term=bold ctermfg=darkyellow gui=none guifg=gold3
hi Identifier   term=underline ctermfg=darkgreen guifg=darkolivegreen4
hi Ignore   term=bold ctermfg=darkgray guifg=gray45
hi Special  term=underline ctermfg=brown guifg=sienna
hi Error    term=reverse ctermfg=gray ctermbg=red guifg=gray guibg=red3
hi Todo     term=standout ctermfg=black ctermbg=yellow gui=bold guifg=gray10 guibg=yellow4
hi Underlined   term=underline cterm=underline ctermfg=darkblue gui=underline guifg=slateblue
hi Number   term=underline ctermfg=darkred guifg=red2

" syntax hi links
hi link String      Constant
hi link Character   Constant
hi link Number      Constant
hi link Boolean     Constant
hi link Float       Number
hi link Function    Identifier
hi link Number      Constant
hi link Conditional Statement
hi link Repeat      Statement
hi link Label       Statement
hi link Keyword     Statement
hi link Exception   Statement
hi link Operator    Statement
hi link Include     PreProc
hi link Define      PreProc
hi link Macro       PreProc
hi link PreCondit   PreProc
hi link StorageClass    Type
hi link Structure   Type
hi link Typedef     Type
hi link Tag     Special
hi link SpecialChar Special
hi link Delimiter   Special
hi link SpecialComment  Special
hi link Debug       Special
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
