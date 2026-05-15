-- Bufferline
require("bufferline").setup({
	options = {
		mode = "buffers", -- set to "tabs" to only show tabpages instead
		themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
		numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		buffer_close_icon = "✗",
		close_icon = "✗",
		modified_icon = "●",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 30,
		max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
		tab_size = 21,
		diagnostics = false,
		diagnostics_update_in_insert = false,
		color_icons = true,
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		separator_style = { "│", "│" }, -- | "thick" | "thin" | { 'any', 'any' },
		enforce_regular_tabs = true,
		always_show_bufferline = true,
		show_tab_indicators = false,
		indicator = {
			-- icon = '▎', -- this should be omitted if indicator style is not 'icon'
			style = "none", -- Options: 'icon', 'underline', 'none'
		},
		icon_pinned = "󰐃",
		minimum_padding = 1,
		maximum_padding = 5,
		maximum_length = 15,
		sort_by = "insert_at_end",
		offsets = {
			{
				filetype = "neo-tree",
				text = "Neotree",
				text_align = "center",
				separator = true,
			},
		},
	},
	highlights = {
		separator = {
			fg = "#434C5E",
		},
		buffer_selected = {
			bold = true,
			italic = true,
		},
		-- separator_selected = {},
		-- tab_selected = {},
		-- background = {},
		-- indicator_selected = {},
		-- fill = {},
	},
})

-- WhichKey
require("which-key").setup({
	options = {
		preset = "helix",
	},
})

-- Lualine
local mode = {
	"mode",
	fmt = function(str)
		return " " .. str
		-- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
	end,
}

local filename = {
	"filename",
	file_status = true, -- displays file status (readonly status, modified status)
	path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
}

local hide_in_width = function()
	return vim.fn.winwidth(0) > 100
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " ", info = " ", hint = " " },
	colored = false,
	update_in_insert = false,
	always_visible = false,
	cond = hide_in_width,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
}

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "tokyonight", -- Set theme based on environment variable
		-- Some useful glyphs:
		-- https://www.nerdfonts.com/cheat-sheet
		--       
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "alpha", "neo-tree" },
		},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { "branch" },
		lualine_c = { filename },
		lualine_x = {
			diagnostics,
			diff,
			{ "encoding", cond = hide_in_width },
			{ "filetype", cond = hide_in_width },
		},
		lualine_y = { "location" },
		lualine_z = { "progress" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { { "location", padding = 0 } },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "fugitive", "fzf" },
})

-- Neotree

require("neo-tree").setup({
	sources = {
		"filesystem",
		"buffers",
		"git_status",
	},
	close_if_last_window = true,
	open_files_do_not_replace_types = {
		"terminal",
		"Trouble",
		"trouble",
		"qf",
		"Outline",
	},
	filesystem = {
		bind_to_cwd = false,
		follow_current_file = { enabled = true },
		use_libuv_file_watcher = true,
	},
	window = {
		width = 25,
		mappings = {
			["l"] = "open",
			["h"] = "close_node",
			["<space>"] = "none",
			["Y"] = {
				function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					vim.fn.setreg("+", path, "c")
				end,
				desc = "Copy Path to Clipboard",
			},
			["P"] = { "toggle_preview", config = { use_float = false } },
		},
	},
	source_selector = {
		winbar = true,
		statusline = false,
	},
	default_component_configs = {
		indent = {
			with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		git_status = {
			symbols = {
				unstaged = "󰄱",
				staged = "󰱒",
			},
		},
	},
})

-- toggleterm
require("toggleterm").setup({
	size = 15,
	open_mapping = nil,
	hide_numbers = true,
	shade_terminals = true,
	shading_factor = 1,
	start_in_insert = true,
	insert_mappings = true,
	terminal_mappings = true,
	persist_size = false,
	direction = "horizontal", -- "vertical" | "horizontal" | "tab" | "float"
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
	},
})

local logo = [[
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░    ░░░░░   ░░░░░░░░░░░░░░░░░░░░░░░   ░░░░░░░░░   ░░░░░░░░░░░░░░░░░░
▒  ▒   ▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒   ▒▒▒  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒
▒   ▒   ▒▒   ▒▒▒▒   ▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒   ▒▒▒▒▒   ▒▒▒▒▒▒▒    ▒   ▒   ▒
▓   ▓▓   ▓   ▓▓  ▓▓▓   ▓▓▓   ▓▓   ▓▓▓▓▓   ▓▓▓   ▓▓▓▓   ▓▓   ▓▓  ▓▓   
▓   ▓▓▓  ▓   ▓         ▓▓   ▓▓▓▓   ▓▓▓▓▓   ▓   ▓▓▓▓▓   ▓▓   ▓▓  ▓▓   
▓   ▓▓▓▓  ▓  ▓  ▓▓▓▓▓▓▓▓▓▓   ▓▓   ▓▓▓▓▓▓▓     ▓▓▓▓▓▓   ▓▓   ▓▓  ▓▓   
█   ██████   ███     ███████   ███████████   ███████   █    ██  ██   
█████████████████████████████████████████████████████████████████████
]]

require("dashboard").setup({
	theme = "doom",
	config = {
		header = vim.split(logo, "\n"),
		center = {
			{ action = "FzfLua files", desc = " Find File", icon = " ", key = "f" },
			{ action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
			{ action = "FzfLua live_grep", desc = " Find Text", icon = " ", key = "g" },
			{
				action = function()
					require("persistence").select()
				end,
				desc = " Restore Session",
				icon = " ",
				key = "s",
			},
			{
				action = function()
					vim.api.nvim_input("<cmd>qa<cr>")
				end,
				desc = " Quit",
				icon = " ",
				key = "q",
			},
		},
	},
})

-- LazyGit

vim.keymap.set(
	"n",
	"<leader>lg",
	"<cmd>LazyGit<cr><cmd>hi LazyGitFloat guibg=NONE guifg=NONE<cr><cmd>setlocal winhl=NormalFloat:LazyGitFloat<cr>",
	{ desc = "LazyGit" }
)
