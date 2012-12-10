" Vim syntax file
" Language:   TestScript
" Maintainer: Ratnikov E.V. <evgeny@sirena2000.ru>

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn keyword tsKeywords define
syn match tsNumber      "\<[0-9]*\>"
syn match tsComment     "#.*$"
syn match tsTlgIn       "^<<"
syn match tsTlgOut      "^>>"
syn match tsCheck       "^??"
syn match tsCase        "^%%"
syn match tsEndReq      ";;$"
syn region tsVariable   start="\$("  end=")" contains=tsVariable

hi def link tsKeywords      Special
hi def link tsNumber        Number
hi def link tsComment       Comment
hi def link tsTlgOut        PreProc
hi def link tsTlgIn         PreProc
hi def link tsCheck         PreProc
hi def link tsCase          PreProc
hi def link tsEndReq        PreProc
hi def link tsVariable      Statement

let b:current_syntax = "ts"
