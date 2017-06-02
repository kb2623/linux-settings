call plug#begin()

Plug 'chriskempson/base16-vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'cohama/lexima.vim'
Plug 'alvan/vim-closetag'
Plug 'lervag/vimtex'
Plug 'sheerun/vim-polyglot'
Plug 'whatyouhide/vim-gotham'

call plug#end()

set number
syntax on
filetype indent plugin on
filetype plugin on
set ruler
set wrap
set breakindent
set breakindentopt=shift:1
set tabstop=3
set shiftwidth=3
set autoindent
set laststatus=2
set t_Co=256
let g:airline#extensions#tabline#enabled=1
if has("gui_running")
	" let g:airline_powerline_fonts=1
	colorscheme base16-default-dark
	set guioptions-=m
	set guioptions-=T
	set guioptions-=r
	set guioptions-=L
	if has("unix")
		set guifont=Liberation\ Mono\ Regular\ 10
	else
		set guifont=Sauce_Code_Powerline:h7:cEASTEUROPE
	endif
	set guicursor+=n-v-c:blinkon0
	hi NonText guifg=bg
else
	let g:airline_theme='base16_google'
endif
nmap <F8> :TagbarToggle<CR>
nmap <F7> :NERDTreeToggle<CR>
set backupdir=/tmp
set directory=/tmp
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
let g:tagbar_compact=1
let g:tagbar_indent=1
