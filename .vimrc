execute pathogen#infect()
set number
syntax on
filetype indent plugin on
set background=dark
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
let g:airline_powerline_fonts=1
if has("gui_running")
	colorscheme solarized
	set guioptions-=m
	set guioptions-=T
	set guioptions-=r
	set guioptions-=L
	if has("unix")
		set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
	else
		set guifont=Sauce_Code_Powerline:h7:cEASTEUROPE
	endif
	set guicursor+=n-v-c:blinkon0
	hi NonText guifg=bg
else
endif
nmap <F8> :TagbarToggle<CR>
nmap <F7> :NERDTreeToggle<CR>
set backupdir=/tmp
set directory=/tmp
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"
