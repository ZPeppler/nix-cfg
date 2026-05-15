require("nvim-autopairs").setup()

-- FZFLua
require("fzf-lua").setup()
require("fzf-lua").register_ui_select()

-- Noice
require("noice").setup({
	presets = {
		bottom_search = false,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
})

require("blink.cmp").setup({
	signature = {
		enabled = true,
		window = { border = "rounded" },
	},
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
			window = { border = "rounded" },
		},
		menu = {
			border = "rounded",
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
	},
	keymap = {
		preset = "default",
		["<C-k>"] = false,
		["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
	},
})

-- Indent Blankline
require("ibl").setup({
	indent = {
		char = "▏",
	},
	scope = {
		show_start = false,
		show_end = false,
		show_exact_scope = false,
	},
	exclude = {
		filetypes = {
			"dashboard",
		},
	},
})

-- neoscroll
require("neoscroll").setup({
	hide_cursor = true,
	stop_eof = true,
	easing = "quadratic",
})
