if exists(':GuiFont')
	GuiFont FantasqueSansMono\ Nerd\ Font\ Mono:h12
else
	set guifont=FantasqueSansMono\ Nerd\ Font\ Mono:h12
endif

if exists(':GuiTablline')
	GuiTablline 0
endif

hi NonText guifg=black

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
