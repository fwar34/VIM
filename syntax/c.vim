"将下面的文本添加到~/.vim/syntax/c.vim最后，c.vim可以从/usr/share/vim/vim7X/syntax/c.vim拷贝，同时把cpp.vim也拷贝
"highlight Functions 函数类等都高亮
""syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
""syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
""hi cFunctions guifg=#7fd02e cterm=bold ctermfg=yellow
""syn match cClass "\<[a-zA-Z_][a-zA-Z_0-9]*\>::"me=e-2
""hi cClass guifg=#7fd02e cterm=bold ctermfg=yellow

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"highlight Functions 只函数名字高亮
syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
hi cFunctions gui=NONE cterm=bold  ctermfg=blue
