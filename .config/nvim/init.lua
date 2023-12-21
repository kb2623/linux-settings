local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

require("paq") {
	"savq/paq-nvim";                  -- Let Paq manage itself
	"preservim/tagbar";
	"nvim-lualine/lualine.nvim";
	"cohama/lexima.vim";
	"alvan/vim-closetag";
	"lervag/vimtex";
	"kyazdani42/nvim-tree.lua";
	"kyazdani42/nvim-web-devicons"; -- optional, for file icon
}

require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = false,
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	extensions = {}
}

require('nvim-tree').setup {
	auto_close = false,
	auto_reload_on_write = true,
	disable_netrw = false,
	hide_root_folder = false,
	hijack_cursor = false,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	ignore_buffer_on_setup = false,
	open_on_setup = false,
	open_on_tab = false,
	sort_by = "name",
	update_cwd = false,
	view = {
		width = 30,
		height = 30,
		side = "left",
		preserve_window_proportions = false,
		number = false,
		relativenumber = false,
		signcolumn = "yes",
		mappings = {
			custom_only = false,
			list = {
				-- user mappings go here
			},
		},
	},
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	update_focused_file = {
		enable = false,
		update_cwd = false,
		ignore_list = {},
	},
	ignore_ft_on_setup = {},
	system_open = {
		cmd = nil,
		args = {},
	},
	diagnostics = {
		enable = false,
		show_on_dirs = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	filters = {
		dotfiles = false,
		custom = {},
		exclude = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 400,
	},
	actions = {
		change_dir = {
			enable = true,
			global = false,
		},
		open_file = {
			quit_on_open = false,
			resize_window = false,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	log = {
		enable = false,
		truncate = false,
		types = {
			all = false,
			config = false,
			git = false,
		},
	},
}

vim.opt.mouse = "a"

vim.o.number = true
vim.o.ruler = true
vim.o.wrap = true
vim.o.breakindent = true
vim.o.tabstop = 3
vim.o.autoindent = true
vim.o.shiftwidth = 3
vim.o.shell = "/bin/zsh"
vim.o.encoding = "UTF-8"

vim.g.closetag_filetypes = 'html,xhtml,phtml'
vim.g.tagbar_compact = true
vim.g.tagbar_indent = 1
vim.g.airline_powerline_fonts = true
vim.g.airline_theme = 'base16_spacemacs'

local function map(mode, lhs, rhs, opts)
	local options = {noremap = true}
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<F7>", "<cmd>NvimTreeToggle<cr>")
map("n", "<F8>", "<cmd>TagbarToggle<cr>")

-- Put anything you want to happen only in Neovide here
if vim.g.neovide then
	-- Font
	vim.o.guifont = "FantasqueSansM Nerd Font:h13"
	-- Line spacing
	vim.opt.linespace = 0
	-- Scale
	vim.g.neovide_scale_factor = 1.0
	-- Padding
	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0
	-- Theme (light, dark, auto)
	vim.g.neovide_theme = 'dark'
	-- Refresh Rate
	vim.g.neovide_refresh_rate = 60
	-- Idle refresh rate
	vim.g.neovide_refresh_rate_idle = 5
	-- No idel
	vim.g.neovide_no_idle = false
	-- Profiler
	vim.g.neovide_profiler = false
	-- Animation Length
	vim.g.neovide_cursor_animation_length = 0.15
	-- Animation Trail Size
	vim.g.neovide_cursor_trail_size = 0.7
	-- Antialiasing
	vim.g.neovide_cursor_antialiasing = true
	-- Cursor Particles (railgun, torpedo, pixiedust, sonicboom, ripple, wireframe)
	vim.g.neovide_cursor_vfx_mode = "railgun"
	-- Particle Lifetime
	vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
	-- Particle Density
	vim.g.neovide_cursor_vfx_particle_density = 7.0
	-- Particle Speed
	vim.g.neovide_cursor_vfx_particle_speed = 9.0
	-- Particles Phase
	vim.g.neovide_cursor_vfx_particle_pahase = 1.3
	-- Particles Curl
	vim.g.neovide_cursor_vfx_particle_curl = 0.9
end
