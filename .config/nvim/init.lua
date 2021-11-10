local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

require "paq" {
    "savq/paq-nvim";                  -- Let Paq manage itself
	 "scrooloose/nerdtree";
	 "majutsushi/tagbar";
	 "bling/vim-airline";
	 "vim-airline/vim-airline-themes";
	 "cohama/lexima.vim";
	 "alvan/vim-closetag";
	 "lervag/vimtex";
	 "ryanoasis/vim-devicons";
}

vim.o.number = true
vim.o.ruler = true
vim.o.wrap = true
vim.o.breakindent = true
vim.o.tabstop = 3
vim.o.autoindent = true
vim.o.shiftwidth = 3
vim.o.shell = "/bin/zsh"
vim.o.encoding = "UTF-8"

vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml"
vim.g.tagbar_compact = true

local function map(mode, lhs, rhs, opts)
	local options = {noremap = true}
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<F7>", "<cmd>NERDTreeToggle<cr>")
map("n", "<F8>", "<cmd>TagbarToggle<cr>")
