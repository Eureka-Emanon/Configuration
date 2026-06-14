"switch buffers
nnoremap <space>b :buffers<CR>:b<space>

" %F 显示当前文件的完整路径
" %m 显示修改标志（[+]）
" %r 显示只读标志（[RO]）
" %y 显示文件类型
set statusline=%F%m%r\ [%Y]

set title titlestring=%F

:colorscheme unokai

imap jk <ESC>

"switch windows"
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

set guifont=Consolas:h14

set foldenable " 开始折叠
set foldmethod=indent " 设置语法折叠
"set foldcolumn=0 " 设置折叠区域的宽度
"setlocal foldlevel=1 " 设置折叠层数为 1

" 不设定在插入状态无法用退格键和 Delete 键删除回车符
set backspace=indent,eol,start

syntax on

" 显示行号"
set nu
"相对行号"
set relativenumber

" 显示标尺"
set ruler

"set cursorline

" 将搜索内容反白"
set hlsearch

" 可以删除任意值"
set backspace=2

"光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号"
set showmatch

set clipboard=unnamedplus

"取消警铃"
set belloff=all

" 设置(软)制表符宽度为4"
set tabstop=4
set softtabstop=4

" 设置缩进的空格数为4"
set shiftwidth=4

"设置tab自动转换为空格"
set expandtab

" 设置自动缩进：即每行的缩进值与上一行相等；使用 noautoindent 取消设置："
set autoindent
