" 定义一个命令 :MakeHero，专门用于 handmade 项目
" command! -nargs=* Hmake execute 'cd F:\handmade_build' | set makeprg=..\handmade\code\build.bat | execute 'make ' . <q-args> | execute 'cd F:\handmade\code' | execute ':copen'

set mouse=a

" 启用 matchit 插件（Vim 自带，只需加载）
" 可以按%在#if #endif之间跳转
packadd! matchit
" 低版本可以用:
" runtime macros/matchit.vim

" Fuzzy file finding
" Search down into subfolders
" use :find and * to make it fuzzy
set path+=**

" display all matching files when using tab complete
set wildmenu

" anyway this is a built-in plugin
filetype plugin on

" 显示状态栏
set laststatus=2

filetype plugin indent on

" 设置撤销历史
set undodir=~/.vim/undo//
set undofile

" 增亮搜索
set incsearch
"" 忽略大小写
" set ignorecase
"" 搜索内容包含大写时大小写敏感
" set smartcase

" 设置终端支持256色
set t_Co=256

" 显示命令行输入时提示
set showcmd

"" 隐藏菜单栏
"set guioptions-=mT

"switch buffers
nnoremap <space>b :buffers<CR>:b<space>

" 向终端粘贴
nnoremap <space>p :call term_sendkeys('', @")<CR>

" %F 显示当前文件的完整路径
" %m 显示修改标志（[+]）
" %r 显示只读标志（[RO]）
" %y 显示文件类型
set statusline=%F%m%r\ [%Y]

set title titlestring=%F

" :colorscheme unokai
:colorscheme darkslategrey

imap jk <ESC>

"switch windows"
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

set guifont=Consolas:h18

" 选择一种折叠方法（根据你的需求选择一种）
set foldmethod=manual
" set foldmethod=indent   " 根据缩进折叠，适合代码
" set foldmethod=marker " 根据 {{{ }}} 标记折叠
" set foldmethod=syntax " 根据语法折叠（需配合语法文件）

" 关键：设置打开文件时的初始折叠级别为最大，即全部展开
set foldlevelstart=99

" 另外，确保 foldlevel 在本次会话中不会意外变小
set foldlevel=99

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
"set expandtab

" 设置自动缩进：即每行的缩进值与上一行相等；使用 noautoindent 取消设置："
set autoindent

" START
" nnoremap ,md :-1read $HOME/test.md<CR>

" 更好的自动补全
" vim: set noet fenc=utf-8 ff=unix sts=4 sw=4 ts=4 :
"
" apc.vim - auto popup completion window
"
" Created by skywind on 2020/03/05
" Last Modified: 2022/12/05 21:22
"
" Features:
"
" - auto popup complete window without select the first one
" - tab/s-tab to cycle suggestions, <c-e> to cancel
" - use ApcEnable/ApcDisable to toggle for certiain file.
"
" Usage:
"
" set cpt=.,k,b
" set completeopt=menu,menuone,noselect
" let g:apc_enable_ft = {'text':1, 'markdown':1, 'php':1}

let g:apc_enable_ft = get(g:, 'apc_enable_ft', {})    " enable filetypes
let g:apc_enable_tab = get(g:, 'apc_enable_tab', 1)   " remap tab
let g:apc_min_length = get(g:, 'apc_min_length', 2)   " minimal length to open popup
let g:apc_key_ignore = get(g:, 'apc_key_ignore', [])  " ignore keywords
let g:apc_trigger = get(g:, 'apc_trigger', "\<c-n>")  " which key to trigger popmenu

" get word before cursor
function! s:get_context()
	return strpart(getline('.'), 0, col('.') - 1)
endfunc

function! s:meets_keyword(context)
	if g:apc_min_length <= 0
		return 0
	endif
	let matches = matchlist(a:context, '\(\k\{' . g:apc_min_length . ',}\)$')
	if empty(matches)
		return 0
	endif
	for ignore in g:apc_key_ignore
		if stridx(ignore, matches[1]) == 0
			return 0
		endif
	endfor
	return 1
endfunc

function! s:check_back_space() abort
	  return col('.') < 2 || getline('.')[col('.') - 2]  =~# '\s'
endfunc

function! s:on_backspace()
	if pumvisible() == 0
		return "\<BS>"
	endif
	let text = matchstr(s:get_context(), '.*\ze.')
	return s:meets_keyword(text)? "\<BS>" : "\<c-e>\<bs>"
endfunc


" autocmd for CursorMovedI
function! s:feed_popup()
	let enable = get(b:, 'apc_enable', 0)
	let lastx = get(b:, 'apc_lastx', -1)
	let lasty = get(b:, 'apc_lasty', -1)
	let tick = get(b:, 'apc_tick', -1)
	if &bt != '' || enable == 0 || &paste
		return -1
	endif
	let x = col('.') - 1
	let y = line('.') - 1
	if pumvisible()
		let context = s:get_context()
		if s:meets_keyword(context) == 0
			call feedkeys("\<c-e>", 'n')
		endif
		let b:apc_lastx = x
		let b:apc_lasty = y
		let b:apc_tick = b:changedtick
		return 0
	elseif lastx == x && lasty == y
		return -2
	elseif b:changedtick == tick
		let lastx = x
		let lasty = y
		return -3
	endif
	let context = s:get_context()
	if s:meets_keyword(context)
		silent! call feedkeys(get(b:, 'apc_trigger', g:apc_trigger), 'n')
		let b:apc_lastx = x
		let b:apc_lasty = y
		let b:apc_tick = b:changedtick
	endif
	return 0
endfunc

" autocmd for CompleteDone
function! s:complete_done()
	let b:apc_lastx = col('.') - 1
	let b:apc_lasty = line('.') - 1
	let b:apc_tick = b:changedtick
endfunc

" enable apc
function! s:apc_enable()
	call s:apc_disable()
	augroup ApcEventGroup
		au!
		au CursorMovedI <buffer> nested call s:feed_popup()
		au CompleteDone <buffer> call s:complete_done()
	augroup END
	let b:apc_init_autocmd = 1
	if g:apc_enable_tab
		inoremap <silent><buffer><expr> <tab>
					\ pumvisible()? "\<c-n>" :
					\ <SID>check_back_space() ? "\<tab>" : 
					\ get(b:, 'apc_trigger', g:apc_trigger)
		inoremap <silent><buffer><expr> <s-tab>
					\ pumvisible()? "\<c-p>" : "\<s-tab>"
		let b:apc_init_tab = 1
	endif
	if get(g:, 'apc_cr_confirm', 0) == 0
		inoremap <silent><buffer><expr> <cr> 
					\ pumvisible()? "\<c-y>\<cr>" : "\<cr>"
	else
		inoremap <silent><buffer><expr> <cr> 
					\ pumvisible()? "\<c-y>" : "\<cr>"
	endif
	inoremap <silent><buffer><expr> <bs> <SID>on_backspace()
	let b:apc_init_bs = 1
	let b:apc_init_cr = 1
	let b:apc_save_infer = &infercase
	setlocal infercase
	let b:apc_enable = 1
endfunc

" disable apc
function! s:apc_disable()
	if get(b:, 'apc_init_autocmd', 0)
		augroup ApcEventGroup
			au! 
		augroup END
	endif
	if get(b:, 'apc_init_tab', 0)
		silent! iunmap <buffer><expr> <tab>
		silent! iunmap <buffer><expr> <s-tab>
	endif
	if get(b:, 'apc_init_bs', 0)
		silent! iunmap <buffer><expr> <bs>
	endif
	if get(b:, 'apc_init_cr', 0)
		silent! iunmap <buffer><expr> <cr>
	endif
	if get(b:, 'apc_save_infer', '') != ''
		let &l:infercase = b:apc_save_infer
	endif
	let b:apc_init_autocmd = 0
	let b:apc_init_tab = 0
	let b:apc_init_bs = 0
	let b:apc_init_cr = 0
	let b:apc_save_infer = ''
	let b:apc_enable = 0
endfunc

" check if need to be enabled
function! s:apc_check_init()
	if &bt != '' || get(b:, 'apc_enable', 1) == 0
		return
	endif
	if get(g:apc_enable_ft, &ft, 0) != 0
		ApcEnable
	elseif get(g:apc_enable_ft, '*', 0) != 0
		ApcEnable
	elseif get(b:, 'apc_enable', 0)
		ApcEnable
	endif
endfunc

" commands & autocmd
command! -nargs=0 ApcEnable call s:apc_enable()
command! -nargs=0 ApcDisable call s:apc_disable()

augroup ApcInitGroup
	au!
	au FileType * call s:apc_check_init()
	au BufEnter * call s:apc_check_init()
	au TabEnter * call s:apc_check_init()
augroup END

" enable this plugin for filetypes, '*' for all files.
let g:apc_enable_ft = {'text':1, 'markdown':1, 'php':1,'cpp':1,'c':1}

" source for dictionary, current or other loaded buffers, see ':help cpt'
set cpt=.,k,w,b

" don't select the first item.
set completeopt=menu,menuone,noselect

" suppress annoy messages.
set shortmess+=c
