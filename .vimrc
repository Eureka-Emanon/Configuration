"call plug#begin('~/.vim/plugged')"
"Plug 'scrooloose/nerdtree'"
"call plug#end()" 
"set mouse=a"

"switch windows"
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

set guifont=Consolas:h16

set foldenable " 开始折叠
set foldmethod=syntax " 设置语法折叠
set foldcolumn=0 " 设置折叠区域的宽度
setlocal foldlevel=1 " 设置折叠层数为 1
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR> " 用空格键来开关折叠

" 不设定在插入状态无法用退格键和 Delete 键删除回车符
set backspace=indent,eol,start

 " 1. 启用语法高亮（如果需要）"
syntax on

" 2. 启用文件类型检测"
filetype on

" 3. 启用基于文件类型的插件（包括缩进规则）"
filetype plugin on

" 4. 启用基于文件类型的自动缩进"
filetype indent on

" 其他你的个人配置..."

imap jk <ESC>

"突出显示当前行"
"set cursorline"

" 设置(软)制表符宽度为4"
set tabstop=4
set softtabstop=4

" 设置缩进的空格数为4"
set shiftwidth=4

"设置tab自动转换为空格"
set expandtab

" 设置自动缩进：即每行的缩进值与上一行相等；使用 noautoindent 取消设置："
"set autoindent"

"设置智能缩进"
"set smartindent"

" 使用 C/C++ 语言的自动缩进方式"
"set cindent"

" 设置C/C++语言的具体缩进方式（以我的windows风格为例）："
"set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s"

" 显示行号"
set nu
"相对行号"
set relativenumber

" 显示标尺"
set ruler

" 将搜索内容反白"
set hlsearch

" 可以删除任意值"
set backspace=2

"光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号"
set showmatch

"括号自动匹配补全"
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
"inoremap { {<CR>}<Esc>O"
"inoremap " ""<ESC>i"
"inoremap ' ''<ESC>"

"配色方案"
":colorscheme desert"
":colorscheme zaibatsu"

set clipboard=unnamedplus

"取消警铃"
set belloff=all

