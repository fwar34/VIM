" 主要参考 http://www.cnblogs.com/ma6174/archive/2011/12/10/2283393.html
" 额外添加了 ctags， YouCompleteMe等
"  主要特点 

"1.按F5可以直接编译并执行C、C++、java代码以及执行shell脚本，按“F4”可进行C、C++代码的调试
"2.自动插入文件头 ，新建C、C++源文件时自动插入表头：包括文件名、作者、联系方式、建立时间等，读者可根据需求自行更改
"3.映射“Ctrl + A”为全选并复制快捷键，方便复制代码
"4.按“F2”可以直接消除代码中的空行
"5.“F3”可列出当前目录文件，打开树状文件目录
"6. 支持鼠标选择、方向键移动
"7. 代码高亮，自动缩进，显示行号，显示状态行
""按“Ctrl + P”可自动补全
"9. []、{}、()、""、‘ ‘等都自动补全   --- 如果需要{}做函数形式的补全（右括号自动换行，加一个空行，光标定位到空行，可以看下面的修改提示）
"10. 使用YouCompleteMe提供C++的自动补全提示，效果类似 Visual Studio那种，可以解析系统头文件

" 让配置变更立即生效
"autocmd BufWritePost $MYVIMRC source $MYVIMRC
" vim 自身命令行模式智能补全
set wildmenu

let mapleader = ";"
"let mapleader = "\<Space>"
"
"a.vim .cpp和.h之间切换，:A
"如果cpp没有。h文件的话不切换
let g:alternateNonDefaultAlternate=1
nmap <Leader>a :A<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Vundle相关。Vundle是vim插件管理器，使用它来管理插件很方便，而且功能强大
"https://github.com/gmarik/Vundle.vim#about

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin(‘~/some/path/here‘)

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'fwar34/vim-color-wombat256'
Plugin 'vim-scripts/a.vim'
Plugin 'vim-scripts/c.vim'
"echofunc可以在命令行中提示当前输入函数的原型
Plugin 'vim-scripts/echofunc.vim'
Plugin 'vim-scripts/OmniCppComplete'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/tagbar'
"前面介绍的主题风格对状态栏不起作用，需要借助插件
"Powerline（https://github.com/Lokaltog/vim-powerline ）美化状态栏，在 .vimrc
Plugin 'https://github.com/Lokaltog/vim-powerline.git'
"vimdoc中文
Plugin 'https://github.com/yianwillis/vimcdoc.git'
Plugin 'https://github.com/altercation/vim-colors-solarized.git'
"上图中 STL 容器模板类 unordered\_multimap 并未高亮，对滴，vim 对 C++
"语法高亮支持不够好（特别是 C++11/14 新增元素），必须借由插件
"vim-cpp-enhanced-highlight
"Plugin 'https://github.com/octol/vim-cpp-enhanced-highlight.git'
Plugin 'git@github.com:fwar34/vim-cpp-enhanced-highlight.git'
"书签可视化
"Plugin 'https://github.com/kshenoy/vim-signature.git'
Plugin 'vim-scripts/indexer.tar.gz'
Plugin 'vim-scripts/DfrankUtil'
Plugin 'vim-scripts/vimprj'
"""""""""""""
Plugin 'scrooloose/nerdtree'
Plugin 'fholgado/minibufexpl.vim'

Plugin 'https://github.com/scrooloose/nerdcommenter.git'

"Plugin 'Valloric/YouCompleteMe'
"Plugin 'marijnh/tern_for_vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" >>
" 营造专注气氛
"
" 禁止光标闪烁
set gcr=a:block-blinkon0
"
" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
"
" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T
"
" 将外部命令 wmctrl 控制窗口最大化的命令行参数封装成一个 vim 的函数
fun! ToggleFullscreen()
  call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf
" 全屏开/关快捷键
"map <silent> <F11> :call ToggleFullscreen()<CR>
"" 启动 vim 时自动全屏
"autocmd VimEnter * call ToggleFullscreen()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置插件 indexer 调用 ctags 的参数
" 默认 --c++-kinds=+p+l，重新设置为 --c++-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v
" 默认 --fields=+iaS 不满足 YCM 要求，需改为 --fields=+iaSl
let g:indexer_ctagsCommandLineOptions="--c++-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q"

" 正向遍历同名标签
nmap <Leader>tn :tnext<CR>
" 反向遍历同名标签
nmap <Leader>tp :tprevious<CR>
"
" 基于语义的代码导航
"
"nnoremap <leader>jc :YcmCompleter GoToDeclaration<CR>
" 只能是 #include 或已打开的文件
"nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>

""""""""""""" By  ma6174""""""""""""""""""""

" 显示相关  

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示  

"winpos 5 5          " 设定窗口位置  

"set lines=40 columns=155    " 设定窗口大小  

set number              " 显示行号  

set go=             " 不要图形按钮  

"color asmanian2     " 设置背景主题  

"set guifont=Courier_New:h10:cANSI   " 设置字体  

syntax on           " 语法高亮  

"autocmd InsertLeave * se nocul  " 用浅色高亮当前行  

""autocmd InsertEnter * se cul    " 用浅色高亮当前行  

"set ruler           " 显示标尺  

set showcmd         " 输入的命令显示出来，看的清楚些  

"set cmdheight=1     " 命令行（在状态行下）的高度，设置为1  

"set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)  

"set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离  

set novisualbell    " 不要闪烁(不明白)  

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  

set laststatus=1    " 启动显示状态行(1),总是显示状态行(2)  

set nofoldenable    "不许折叠

"set foldenable      " 允许折叠  

"set foldmethod=manual   " 手动折叠  

"set background=dark "背景使用黑色 


" 显示中文帮助

if version >= 603

    set helplang=cn

    set encoding=utf-8

endif

" 设置配色方案

"colorscheme codeschool

"字体 

"if (has("gui_running")) 

"   set guifont=Bitstream\ Vera\ Sans\ Mono\ 10 

"endif 


 
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936

set termencoding=utf-8

set encoding=utf-8

set fileencodings=ucs-bom,utf-8,cp936

"set fileencoding=utf-8



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""新文件标题""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"新建.c,.h,.sh,.java文件，自动插入文件头 

autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 

""定义函数SetTitle，自动插入文件头 

func SetTitle() 

    "如果文件类型为.sh文件 

    if &filetype == 'sh'

        call setline(1,"\#########################################################################") 

        call append(line("."), "\# File Name: ".expand("%")) 

        call append(line(".")+1, "\# Author: Feng") 
        "原来的时间形式比较复杂，不喜欢，改变一下

        call append(line(".")+2, "\# Created Time: ".strftime("%c")) 
        "call append(line(".")+3, "\# Created Time: ".strftime("%Y-%m-%d",localtime()))

        call append(line(".")+3, "\# Content: ") 


        call append(line(".")+4, "\#########################################################################") 

        call append(line(".")+5, "\#!/bin/bash") 

        call append(line(".")+6, "") 

    else 

        call setline(1, "/*************************************************************************") 

        call append(line("."), "    > File Name: ".expand("%")) 

        call append(line(".")+1, "    > Author: Feng") 
        " 同样的 改变时间格式
        call append(line(".")+2, "    > Created Time: ".strftime("%c")) 
        "call append(line(".")+3, "    > Created Time: ".strftime("%Y-%m-%d",localtime()))

        call append(line(".")+3, "    > Content: ") 


        call append(line(".")+4, " ************************************************************************/") 

        call append(line(".")+5, "")

    endif

    if &filetype == 'cpp'

        call append(line(".")+6, "#include <iostream>")

        call append(line(".")+7, "")

        call append(line(".")+8, "using namespace std;")

        call append(line(".")+9, "")

    endif

    if &filetype == 'c'

        call append(line(".")+6, "#include<stdio.h>")

        call append(line(".")+7, "")

    endif

    "新建文件后，自动定位到文件末尾

    autocmd BufNewFile * normal G

endfunc 

" Suzzz：  模仿上面，新建python文件时，添加文件头

autocmd BufNewFile *py exec ":call SetPythonTitle()"

func SetPythonTitle()
    call setline(1,"#!/usr/bin/env python3")
    call append( line("."),"#-*- coding: utf-8 -*-" )
    call append(line(".")+1," ")
    call append(line(".")+2, "\# File Name: ".expand("%")) 
    call append(line(".")+3, "\# Author: Feng") 
	call append(line(".")+4, "\# Created Time: ".strftime("%c"))
    "call append(line(".")+5, "\# Created Time: ".strftime("%Y-%m-%d",localtime()))    
    call append(line(".")+5, "\# Content: ") 
    autocmd BufNewFile * normal G
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"键盘命令

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""nmap <leader>w :w!<cr>

""nmap <leader>f :find<cr>

" C+]显示列表
"map <C-]> :ts<CR>
map <C-]> g<C-]>
nnoremap <Leader>j g<C-]>


" 映射全选+复制 ctrl+a

""map <C-A> ggVGY

""map! <C-A> <Esc>ggVGY
"编辑模式移动光标,C-h和退格键冲突"
"inoremap <C-h> <Left>
"inoremap <C-j> <Down>
"inoremap <C-k> <Up>
"inoremap <C-l> <Right>
"map <F1> :
"map <C-k> :
map <Space> :
map <F7> :set tags+=
"映射命令行模式C-k到:
"cmap <C-k> :
"omap <C-k> :
"如果经常在不同工程里查阅代码，那么可以在~/.vimrc中添加：
set tags=tags
set autochdir 

"在/usr/include中执行cscope -Rbq -f ~/.vim/sys.out和/tang/include中执行cscope -Rbq -f ~/.vim/tang.out
map <silent> <F6> :!find `pwd` -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "*.cc" -o -name "*.inl" > cscope.files<CR>:!cscope -Rbq -i cscope.files <CR>:cs add cscope.out<CR>:cs add ~/.vim/sys.out ~/.vim/<CR>:cs add ~/.vim/tang.out ~/.vim/<CR>
"map <F2> :ls<CR>

map <C-l> :ls<CR>
nnoremap <Leader>l :ls<CR>
map <Leader>w <C-w><C-w>
nmap <Leader>6 <C-^>
"imap .<Space> <C-n>
imap <Leader>; <C-n>
nnoremap <Leader>m %
nnoremap <Leader>f <C-f>
nnoremap <Leader>b <C-b>
nnoremap <Leader>d <C-d>
nnoremap <Leader>u <C-u>
"map <silent> <F9> :cs add cscope.out

map <silent> <F10> :!ctags -R .<CR><CR>
"map <silent> <F11> :!ctags -R --c++-kinds=+px --fields=+iaS --extra=+q .<CR><CR>
map <silent> <F11> :!ctags -R --c++-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q .<CR><CR>
map <silent> <F12> :!ctags -R --languages=c++ --langmap=c++:+.inl -h +.inl --c++-kinds=+px --fields=+aiKSz --extra=+q .<CR><CR>
" 选中状态下 Ctrl+c 复制

""vmap <C-c> "+y

"去空行  

"nnoremap <F2> :g/^\s*$/d<CR>

"比较文件  

""nnoremap <C-F2> :vert diffsplit 

"新建标签  

""map <M-F2> :tabnew<CR>  

"列出当前目录文件  

map <F3> :tabnew .<CR>  

"打开树状文件目录  

""map <C-F3> \be  
"":autocmd BufRead,BufNewFile *.dot map <F5> :w<CR>:!dot -Tjpg -o %<.jpg % && eog %<.jpg  <CR><CR> && exec "redr!"

"C，C++ 按F5编译运行

map <F5> :call CompileRunGcc()<CR>

func! CompileRunGcc()

    exec "w"

    if &filetype == 'c'
		"先删除上次编译的执行文件"
		if filereadable(expand("%<"))
		    silent exec "!rm %<"
		endif

        exec "!gcc % -o %<"

		"如果编译成功了有了可执行文件才运行"
		if filereadable(expand("%<"))
            exec "! ./%<"
		endif

    elseif &filetype == 'cpp'
		"先删除上次编译的执行文件"
		if filereadable(expand("%<"))
		    silent exec "!rm %<"
		endif

        exec "!g++ -std=c++11 % -o %<"
		
		"如果编译成功了有了可执行文件才运行"
		if filereadable(expand("%<"))
            exec "! ./%<"
		endif

    elseif &filetype == 'java'

        exec "!javac %" 

        exec "!java %<"

    elseif &filetype == 'sh'

        :!./%
		
    elseif &filetype == 'python'
		
        exec "!python3 %"

    endif

endfunc

"C,C++的调试

	map <F4> :call Rungdb()<CR>

func! Rungdb()

    exec "w"

    exec "!g++ -std=c++11 % -g -o %<"
	"如果编译成功了有了可执行文件才调试"
	if filereadable(expand("%<"))
        exec "!gdb ./%<"
	endif

endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""实用设置

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 设置当文件被改动时自动载入

set autoread

" quickfix模式

autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>

"代码补全 

set completeopt=longest,preview,menu 

"允许插件  

filetype plugin on

"共享剪贴板  

set clipboard+=unnamed 

"从不备份  

set nobackup

"make 运行

:set makeprg=g++\ -Wall\ \ -std=c++11\ %

"自动保存

set autowrite

set ruler                   " 打开状态栏标尺

set cursorline              " 突出显示当前行

set magic                   " 设置魔术

set guioptions-=T           " 隐藏工具栏

set guioptions-=m           " 隐藏菜单栏

"set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\

" 设置在状态行显示的信息

set foldcolumn=0

set foldmethod=indent 

set foldlevel=3 


" 去掉输入错误的提示声音

set noeb

" 在处理未保存或只读文件的时候，弹出确认

set confirm

" 自动缩进

set autoindent
set smartindent    "智能的选择对起方式；
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
set cindent
"set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
set cinoptions+=g0,(1s,:0

" 不要用空格代替制表符

set noexpandtab

" 用空格代替制表符
set expandtab

" 在行和段开始处使用制表符

set smarttab

" 历史记录数

set history=1000

"禁止生成临时文件

set nobackup

set noswapfile

"搜索忽略大小写

""set ignorecase

"搜索逐字符高亮

set hlsearch

set incsearch

"行内替换

set gdefault

"编码设置

set enc=utf-8

set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936

"语言设置

set langmenu=zh_CN.UTF-8

set helplang=cn

" 我的状态行显示的内容（包括文件类型和解码）

"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]

" 总是显示状态行

set laststatus=2

" 命令行（在状态行下）的高度，默认为1，这里是2

set cmdheight=2

" 侦测文件类型

filetype on

" 载入文件类型插件

filetype plugin on

" 为特定文件类型载入相关缩进文件

filetype indent on

" 保存全局变量

set viminfo+=!

" 带有如下符号的单词不要被换行分割

set iskeyword+=_,$,@,%,#,-

" 字符间插入的像素行数目

set linespace=0

" 增强模式中的命令行自动完成操作

set wildmenu

" 使回格键（backspace）正常处理indent, eol, start等

set backspace=2

" 允许backspace和光标键跨越行边界

set whichwrap+=<,>,h,l

" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）

set mouse=a

set selection=exclusive

set selectmode=mouse,key

" 通过使用: commands命令，告诉我们文件的哪一行被改变过

set report=0

" 在被分割的窗口间显示空白，便于阅读

set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号

set showmatch

" 匹配括号高亮的时间（单位是十分之一秒）

set matchtime=1

" 光标移动到buffer的顶部和底部时保持3行距离

set scrolloff=3

" 高亮显示普通txt文件（需要txt.vim脚本）

au BufRead,BufNewFile *  setfiletype txt

"自动补全

"":inoremap ( ()<ESC>i

"":inoremap ) <c-r>=ClosePair(')')<CR>

"by Suzzz：  原作者这种设置，输入{会自动补全，并且中间插入一个空行，将光标定位到空行。这对于函数是OK的，但是使用花括号初始化数组、vector时就不方便了。所以改为现在这种。只是补全，然后光标在左右括号中间。
":inoremap { {<CR>}<ESC>O
"":inoremap { {}<ESC>i

"":inoremap } <c-r>=ClosePair('}')<CR>

"":inoremap [ []<ESC>i

"":inoremap ] <c-r>=ClosePair(']')<CR>

"":inoremap " ""<ESC>i

"":inoremap ' ''<ESC>i

function! ClosePair(char)

    if getline('.')[col('.') - 1] == a:char

        return "\<Right>"

    else

        return a:char

    endif

endfunction

filetype plugin indent on 

"打开文件类型检测, 加了这句才可以用智能补全

"set completeopt=longest,menu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" CTags的设定  

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"cd /tang/include/
nmap <Leader><F10> :!ctags -R --c-kinds=+l+x+p --c++-kinds=+l+x+p --fields=+iaSl --extra=+q -f ~/.tags/tang.tags<CR>
"cd到对应的c++目录后打开vi生成stdcpp.tags (例如/usr/include/c++/4.8)
nmap <Leader><F11> :!ctags -R --c++-kinds=+l+x+p --fields=+iaSl --extra=+q --language-force=c++ -f ~/.tags/stdcpp.tags<CR>
"cd /usr/include/
nmap <Leader><F12> :!ctags -R --c-kinds=+l+x+p --fields=+lS -I __THROW,__nonnull -f ~/.tags/sys.tags<CR>
" 引入 C++ 标准库 tags
set tags+=~/.tags/stdcpp.tags
set tags+=~/.tags/sys.tags
set tags+=~/.vim/tang.tags
"
"若要加入系统函数或全局变量的tag标签，则需执行：
"map <silent> <F2> :!ctags -I __THROW --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+px --fields=+ialS --extra=+q -R -f ~/.tags/sys.tags /usr/include /usr/local/include<CR>:!ctags -I __THROW --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+px --fields=+ialS --extra=+q -R -f ~/.tags/tang.tags /tang/include<CR>:set tags+=~/.tags/sys.tags<CR>:set tags+=~/.tags/tang.tags<CR>
"并且在~/.vimrc中添加（亦可用上面描述的手动加入的方式）：

"map <silent> <F2> :!ctags -I __THROW --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v --fields=+ialS --extra=+q -R -f ~/.tags/sys.tags /usr/include /usr/local/include<CR>:!ctags -I __THROW --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v --fields=+ialS --extra=+q -R -f ~/.tags/tang.tags /tang/include<CR>:set tags+=~/.tags/sys.tags<CR>:set tags+=~/.tags/tang.tags<CR>

let Tlist_Sort_Type ="name"    " 按照名称排序  

let Tlist_Use_Right_Window = 1  " 在右侧显示窗口  

let Tlist_Compart_Format = 1    " 压缩方式  

let Tlist_Exist_OnlyWindow = 1  " 如果只有一个buffer，kill窗口也kill掉buffer  

let Tlist_File_Fold_Auto_Close = 0  " 不要关闭其他文件的tags  

let Tlist_Enable_Fold_Column = 0    " 不要显示折叠树  

""autocmd FileType java set tags+=D:\tools\java\tags  

""autocmd FileType h,cpp,cc,c set tags+=D:\tools\cpp\tags  

""let Tlist_Show_One_File=1            "不同时显示多个文件的tag，只显示当前文件的


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Powerline设置

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置状态栏主题风格
let g:Powerline_colorscheme='solarized256'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"可视化书签vim-signature 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "m-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "mda",
        \ 'PurgeMarkers'       :  "m<BS>",
        \ 'GotoNextLineAlpha'  :  "']",
        \ 'GotoPrevLineAlpha'  :  "'[",
        \ 'GotoNextSpotAlpha'  :  "`]",
        \ 'GotoPrevSpotAlpha'  :  "`[",
        \ 'GotoNextLineByPos'  :  "]'",
        \ 'GotoPrevLineByPos'  :  "['",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "[+",
        \ 'GotoPrevMarker'     :  "[-",
        \ 'GotoNextMarkerAny'  :  "]=",
        \ 'GotoPrevMarkerAny'  :  "[=",
        \ 'ListLocalMarks'     :  "ms",
        \ 'ListLocalMarkers'   :  "m?"
        \ }


" 设置状态栏主题风格

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"其他东东

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"默认打开Taglist 

""let Tlist_Auto_Open=1

"""""""""""""""""""""""""""""" 

" Tag list (ctags) 

"""""""""""""""""""""""""""""""" 

let Tlist_Ctags_Cmd = '/usr/bin/ctags' 

let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的 

let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim 

let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口
"设置显示标签列表子窗口的快捷键。速记：taglist
nnoremap <Leader>tl :TlistToggle<CR> 

"""""""""""""""""""""""""""""" 

" Tagbar(ctags) 

"""""""""""""""""""""""""""""""" 
" 设置 tagbar 子窗口的位置出现在主编辑区的左边 
let tagbar_left=1 
" " 设置显示／隐藏标签列表子窗口的快捷键。速记：identifier list by tag
nnoremap <Leader>tb :TagbarToggle<CR> 
" " 设置标签子窗口的宽度 
let tagbar_width=32 
" " tagbar 子窗口中不显示冗余帮助信息 
let g:tagbar_compact=1
" 设置 ctags 对哪些代码标识符生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
         \ 'c:classes:0:1',
         \ 'd:macros:0:1',
         \ 'e:enumerators:0:0', 
         \ 'f:functions:0:1',
         \ 'g:enumeration:0:1',
         \ 'l:local:0:1',
         \ 'm:members:0:1',
         \ 'n:namespaces:0:1',
         \ 'p:functions_prototypes:0:1',
         \ 's:structs:0:1',
         \ 't:typedefs:0:1',
         \ 'u:unions:0:1',
         \ 'v:global:0:1',
         \ 'x:external:0:1'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
     \ }

""""""""""""""""""""""""""""""""
" minibufexpl插件的一般设置

let g:miniBufExplMapWindowNavVim = 1

let g:miniBufExplMapWindowNavArrows = 1

let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 文本格式和排版
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 自动格式化
""set formatoptions=tcrqn

" 只在下列文件类型被侦测到的时候显示行号，普通文本文件不显示
if has("autocmd")
"   autocmd FileType xml,html,c,cs,java,perl,shell,bash,cpp,python,vim,php,ruby,sh set number
"   autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>o-->
"   autocmd FileType java,c,cpp,cs vmap <C-o> <ESC>'<o/*<ESC>'>o*/
"   autocmd FileType html,text,php,vim,c,java,xml,bash,shell,perl,python setlocal textwidth=100
"   autocmd Filetype html,xml,xsl source $VIMRUNTIME/plugin/closetag.vim
"   打开文件时定位到上次退出的光标位置
   autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
endif " has("autocmd")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'       "配置全局路径
let g:ycm_confirm_extra_conf=0   "每次直接加载该文件，不提示是否要加载
let g:ycm_server_python_interpreter='/usr/bin/python'
"" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
let g:ycm_min_num_of_chars_for_completion = 3 
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
" 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=0
"YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
inoremap <leader><Tab> <C-x><C-o>
"
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
"
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
"
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
"
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1

" 比较喜欢用tab来选择补全...
function! MyTabFunction ()
    let line = getline('.')
    let substr = strpart(line, -1, col('.')+1)
    let substr = matchstr(substr, "[^ \t]*$")
    if strlen(substr) == 0
        return "\<tab>"
    endif
    return pumvisible() ? "\<c-n>" : "\<c-x>\<c-o>"
endfunction
inoremap <tab> <c-r>=MyTabFunction()<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Omni
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set completeopt=menu,menuone " 关掉智能补全时的预览窗口
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype in popup window
let OmniCpp_GlobalScopeSearch=1 " enable the global scope search
let OmniCpp_DisplayMode=1 " Class scope completion mode: always show all members
"let OmniCpp_DefaultNamespaces=["std"]
let OmniCpp_ShowScopeInAbbr=1 " show scope in abbreviation and remove the last column
let OmniCpp_ShowAccess=1

""setlocal omnifunc=tern#Complete
""call tern#Enable()

""PS1='\[\033]0;\u@\h:\w\007\]\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\]'

""hi comment ctermfg=6
""hi comment ctermfg=blue
""hi comment ctermfg=green


" 设置配色方案
set t_Co=256
""colorscheme codeschool
colorscheme wombat256
""colorscheme morning
""colorscheme torte

" 成员函数的实现顺序与声明顺序一致
let g:disable_protodef_sorting=1

" <<
"
" >>
" 工程文件浏览
"
" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置 NERDTree 子窗口宽度
let NERDTreeWinSize=22
" 设置 NERDTree 子窗口位置
let NERDTreeWinPos="right"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1
"
" <<
"
" >>
" 多文档编辑
"  
" 显示/隐藏 MiniBufExplorer 窗口
map <Leader>bl :MBEToggle<cr>
"
" buffer 切换快捷键
map <Leader>bn :MBEbn<cr>
map <Leader>bp :MBEbp<cr>
" <<
"
" >>
" 环境恢复
"
" 设置环境保存项
set sessionoptions="blank,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize"
"
" 保存 undo 历史。必须先行创建 .undo_history/
set undodir=~/.undo_history/
set undofile
"
" 保存快捷键
"map <leader>ss :mksession! my.vim<cr> :wviminfo! my.viminfo<cr>
map <leader>ss :mksession! my.vim<cr>
"
" 恢复快捷键
"map <leader>rs :source my.vim<cr> :rviminfo my.viminfo<cr>
map <leader>rs :source my.vim<cr>

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

