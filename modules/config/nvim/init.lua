local opt = vim.opt
local keymap = vim.keymap.set
local key_opts = { noremap = true, silent = true }
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.markdown_recommended_style = 0

-- Performance and Timing
opt.updatetime = 100
opt.lazyredraw = false
opt.synmaxcol = 240
opt.timeoutlen = 500

-- UI & Appearance
-- Enable relative line numbers
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.laststatus = 3
opt.showmode = false
opt.showmatch = true
opt.matchtime = 1
opt.termguicolors = true
opt.winborder = "rounded"

-- Windows & Splits
opt.splitbelow = true
opt.splitright = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- Files and Buffers
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.autoread = true
opt.fileencoding = "utf-8"
opt.modeline = true
opt.modelines = 100

-- Indents and Formatting
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
-- opt.smartindent = true
opt.breakindent = true
opt.preserveindent = true
opt.linebreak = true
opt.wrap = true

-- Completion and Popup
opt.pumheight = 10
opt.infercase = true
opt.completeopt = "menuone,noinsert,noselect"

-- Command Line and Message
opt.cmdheight = 0
opt.history = 100
opt.report = 9001

-- Editor Behavior
opt.virtualedit = "block"
opt.startofline = true
opt.title = true

opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"

opt.scrolloff = 8
opt.mouse = "a"

opt.encoding = "utf-8"

opt.modifiable = true

opt.guicursor = {
	"n-v-c:block", -- Normal, Visual, Command-line
	"i-ci-ve:block", -- Insert, Command-line Insert, Visual-exclusive
	"r-cr:hor20", -- Replace, Command-line Replace
	"o:hor50", -- Operator-pending
	"a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor", -- All modes: blinking & highlight groups
	"sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch mode
}


require '00-pack'

-- Plugin settings

require("tokyonight").setup({
	style = "storm",
})

require("tokyonight").load()

-- Diagnostics
local sev = vim.diagnostic.severity

vim.diagnostic.config({
	severity_sort = true,
	signs = {
		text = {
			[sev.ERROR] = " ",
			[sev.WARN] = " ",
			[sev.INFO] = " ",
			[sev.HINT] = " ",
		},
	},
})

-- Treesitter
require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
	indent = { enable = false },
})

local parsers = {
	"lua",
	"vim",
	"bash",
	"regex",
	"javascript",
	"json",
	"markdown",
	"markdown_inline",
  "powershell",
	"nix",
	"html",
	"latex",
	"yaml",
}

require("nvim-treesitter").install(parsers)

-- LSP and Mason

local lsp_servers = {
	lua_ls = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
	ansiblels = {
		python = {
			interpreterPath = "$HOME/.venv/bin/python",
		},
	},
	bashls = {},
	marksman = {
   filetypes = {
     "markdown",
     "mdx",
   },
  },
	nil_ls = {},
  powershell_es = {},
	jinja_lsp = {
		filetypes = { "jinja" },
	},
	stylua = {},
}

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"shellcheck",
		"shfmt",
		"markdownlint",
		"prettier",
		vim.tbl_keys(lsp_servers),
	},
})

vim.filetype.add({
	pattern = {
		[".*/playbooks./*%.ya?ml"] = "yaml.ansible",
		[".*/roles.*/tasks/.*%.ya?ml"] = "yaml.ansible",
		[".*/group_vars/all/*.*%.ya?ml"] = "yaml.ansible",
	},
	extension = {
		j2 = "jinja",
    md = "markdown",
    mdx = "markdown",
	},
})

autocmd("BufReadPost", {
	pattern = { "*main.yml", "*main.yaml" },
	callback = function()
		vim.bo.filetype = "yaml.ansible"
	end,
})

for server, config in pairs(lsp_servers) do
	vim.lsp.config(server, {
		settings = config,

		on_attach = function(_, bufnr)
			keymap("n", "grd", vim.lsp.buf.definition, { buffer = bufnr, desc = "vim.lsp.buff.defintion()" })

			keymap("n", "grf", vim.lsp.buf.format, { buffer = bufnr, desc = "vim.lsp.buff.format()" })
		end,
	})
end

-- Renderer-Markdown
require("render-markdown").setup()

require("powershell").setup({
  bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
})

autocmd("BufEnter", {
	group = augroup("Neotree_start_directory", { clear = true }),
	desc = "Start Neo-tree with directory",
	once = true,
	callback = function()
		if package.loaded["neo-tree"] then
			return
		else
			local stats = vim.uv.fs_stat(vim.fn.argv(0))
			if stats and stats.type == "directory" then
				require("neo-tree")
			end
		end
	end,
})

autocmd("PackChanged", {
	pattern = "nvim-treesitter",
	desc = "Run :TSUpdate after pack changed",
	group = augroup("treesitter_update", { clear = true }),
	callback = function(e)
		local kind, name
		name = e.data.kind, e.data.spec.name
		if kind == "install" or kind == "update" then
			vim.cmd.packadd({ args = { name }, bang = false })
			vim.cmd("TSUpdate")
		end
	end,
})


-- if entering from neovide, dashboard displays
-- if entering from terminal, will trigger persistence
-- NOTE: this requires sesh+television+tmux

autocmd("VimEnter", {
  callback = function()
    if vim.g.neovide then
      vim.cmd("Dashboard")
    else
      require("persistence").load({
        silent = true,
      })
      vim.cmd("filetype detect")
    end
  end,
})

require 'keymaps'
require 'neovide'
