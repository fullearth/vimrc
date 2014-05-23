" 初期設定
if has('win32') || has('win64')
	:let $VIMFILE_DIR = $VIM.'/vimfiles'
else
	:let $VIMFILE_DIR = $HOME.'/.vim'
endif

" 文字コード関係
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
" key mapping {{{
" タイムスタンプ
inoremap <silent><Leader>date <C-R>=strftime("%Y/%m/%d %H:%M:%S")<ENTER>
" <C-W> into \w
noremap <Leader>w <C-W>
noremap <Leader>wh <C-W>h
noremap <Leader>wj <C-W>j
noremap <Leader>wk <C-W>k
noremap <Leader>wl <C-W>l
nmap <Leader>w+ :resize +1
nmap <Leader>w- :resize -1
nmap <Leader>w> :vertical resize +1
nmap <Leader>w< :vertical resize -1
map <M-.> @:
" 行頭、行末移動
noremap <Space>h ^
noremap <Space>l $
" php tag
inoremap <Leader>php <?php  ?><LEFT><LEFT><LEFT>
" ()
" function! g:needSemicolon()
" 	if &filetype =~ 'ruby\|vim\|htm'
" 		return "\<LEFT>"
" 	else
" 		return ";\<LEFT>\<LEFT>"
" 	endif
" 	return ""
" endfunction
" inoremap <expr><Plug>endSemicolon g:needSemicolon()
" imap (); ()<Plug>endSemicolon
" imap {}; {}<Plug>endSemicolon<CR><ESC>O
" imap []; []<Plug>endSemicolon
" imap ""; ""<Plug>endSemicolon
" imap ''; ''<Plug>endSemicolon
" imap //; //<Plug>endSemicolon
inoremap <> <><LEFT>
inoremap {<CR> {<CR>}<ESC>O

" commnet
inoremap <LEADER>comment //<ESC>40a*<ESC>yypO<Space>
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" <ESC> with OFF IME
inoremap <silent><C-J> <ESC>:set iminsert=0<CR>
vnoremap <silent><C-J> <ESC>:set iminsert=0<CR>
let IM_CtrlIBusPython = 1
" 上下のカーソル移動を実際の行ではなく見た目の行で移動
noremap j gj
noremap k gk
" 改行を含まない1行ヤンク
noremap <Space>yy ^y$
" }}}
"先頭、末尾での左右移動での行移動サンプル
set whichwrap=b,s,<,>,[,]
" set command
" 行末を無視して矩形選択
set virtualedit+=block
" タブ幅2、スペースでインデントをデフォルトにする
set tabstop=2 " タブ幅を2に設定
set expandtab " タブをスペースに変換
set softtabstop=2
set autoindent
set backspace=indent,eol,start " バックスペースでインデント、改行などを削除可能にする。
set shiftwidth=2 " インデントの各段階に使われる空白の数
" タブ幅の個別設定
augroup Tab
	autocmd!
	autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd FileType haskell setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd FileType python setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END
" end tab
set list
set listchars=tab:>-,trail:-,eol:$
set hidden
set confirm
set clipboard+=unnamed
set number
set visualbell t_vb=	"ビープ音無効
set formatoptions=q	"自動改行(tw)回避
set textwidth=0
set splitright
set ignorecase "検索時の大文字小文字を無視
set smartcase "大文字小文字が混在していた場合は無視しない。
"ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set browsedir=buffer 
set scrolloff=99	"カーソルの上下に表示する最小の行
set sidescrolloff=99	"カーソルの左右に表示する最小の文字数
set laststatus=2
set statusline=%<%f%y%{winnr('$')>1?':'.winnr().'/'.winnr('$'):''}\ %m%r%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l/%L,%v@%{b:charCounterCount}
syntax on
" .vimrcの編集時にdropboxが自己主張激しいのでswapとbackupをカレントから別の場所に移動
" ~/.vimswap,~/.vimbackupが無かった場合はカレント。
set swapfile
set directory=$HOME/.vimswap,.
set backup
set backupdir=$HOME/.vimbackup,.
" --------------------
"plugin
"neoBundle
set nocompatible
filetype off
if has('vim_starting')
	set runtimepath+=$VIMFILE_DIR/.bundle/neobundle.vim
	call neobundle#rc(expand('$VIMFILE_DIR/.bundle'))
endif
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'tpope/vim-surround'
NeoBundle 'anekos/char-counter-vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'Markdown'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'dag/vim2hs'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'tyru/caw.vim'

if has('win32') || has('win64')
	
else
	NeoBundle 'fuenor/im_control.vim'
	set timeout timeoutlen=3000 ttimeoutlen=100
endif
filetype plugin on
filetype indent on
" Neobundle--end
" VimFiler
nnoremap <silent><Leader>vf :VimFiler -split -simple -winwidth=35 -no-quit<CR>
call unite#custom_default_action('source/bookmark/directory','vimfiler')
" end VimFiler
" vim-quickrun
if has('win32') || has('win64')
	nmap <Leader>rcc :QuickRun -cmdopt /EHsc -hook/output_encode/encoding "Shift_jis"
	nmap <Leader>rci :QuickRun -cmdopt /EHsc -hook/output_encode/encoding "Shift_jis" -input ""<LEFT>
endif
nmap <Leader>ra :QuickRun -input "="<LEFT>
let g:quickrun_config = {"_":{"outputter/buffer/into" : 1,},}
" end vim-quickrun
" emmet vim
let g:user_emmet_settings = {
			\ 'lang' : 'ja',
\}
" end emmet vim
" NeoComplete
let g:neocomplete#enable_at_startup = 1
" NeoComplete end
" vim2hs
" vim2hs end
