local keymap = vim.keymap.set
local key_opts = { noremap = true, silent = true }

-- General keymaps
keymap("n", "gl", function()
	vim.diagnostic.open_float()
end, { desc = "Open Diagnostic in float" })
keymap("n", "<leader>cf", function()
	require("conform").format({
		lsp_format = "fallback",
	})
end, { desc = "Format [c]urrent [f]ile" })

-- Disable spacebar's default behavior
keymap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- save file
keymap("n", "<C-s>", "<cmd> w <CR>", key_opts)

-- save file w/o auto-format
keymap("n", "<C-a>", "<cmd> noautocmd w <CR>", key_opts)

-- source
keymap("n", "<C-S-r>", "<CMD>so<CR>", key_opts)

-- quit file
keymap("n", "<C-q>", "<cmd> q <CR>", key_opts)

-- delete character w/o copy into register
keymap("n", "x", '"_x', key_opts)

-- Vertical Scroll and center
keymap("n", "<C-d>", "<C-d>zz", key_opts)
keymap("n", "<C-u>", "<C-u>zz", key_opts)

-- Find and center
keymap("n", "n", "nzzzv", key_opts)
keymap("n", "N", "Nzzzv", key_opts)

-- Resize with arrows
keymap("n", "<S-Up>", ":resize -2<CR>", key_opts)
keymap("n", "<S-Down>", ":resize +2<CR>", key_opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", key_opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", key_opts)

-- Buffers
keymap("n", "<Tab>", ":bnext<CR>", key_opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", key_opts)
keymap("n", "<leader>x", ":Bdelete!<CR>", key_opts) -- close buffer
keymap("n", "<leader>b", "<cmd> enew <CR>", key_opts) -- new buffer

-- Window management
keymap("n", "<leader>v", "<C-w>v", key_opts) -- split window vertically
keymap("n", "<leader>h", "<C-w>s", key_opts) -- split window horizontally
keymap("n", "<leader>se", "<C-w>=", key_opts) -- split windows equally w/h
keymap("n", "<leader>xs", ":close<CR>", key_opts) -- close current split window

-- Navigate between splits
keymap("n", "<C-k>", ":wincmd k<CR>", key_opts)
keymap("n", "<C-j>", ":wincmd j<CR>", key_opts)
keymap("n", "<C-h>", ":wincmd h<CR>", key_opts)
keymap("n", "<C-l>", ":wincmd l<CR>", key_opts)

-- Tabs
keymap("n", "<leader>to", ":tabnew<CR>", key_opts) -- open new tab
keymap("n", "<leader>tx", ":tabclose<CR>", key_opts) -- close current tab
keymap("n", "<leader>tn", ":tabn<CR>", key_opts) --  go to next tab
keymap("n", "<leader>tp", ":tabp<CR>", key_opts) --  go to previous tab

-- Toggle line wrapping
keymap("n", "<leader>lw", "<cmd>set wrap!<CR>", key_opts)

-- Stay in indent mode
keymap("v", "<", "<gv", key_opts)
keymap("v", ">", ">gv", key_opts)

-- Keep last yanked when pasting
keymap("v", "p", '"_dP', key_opts)

-- Clear search highlights
keymap("n", "<Esc>", "<CMD>nohlsearch<CR>")

-- FZF lua
keymap("n", "<leader>ff", "<CMD>FzfLua files<CR>", { desc = "Find Files" })
keymap("n", "<leader>fh", "<CMD>FzfLua helptags<CR>", { desc = "Find Helptags" })
keymap("n", "<leader>fk", "<CMD>FzfLua keymaps<CR>", { desc = "Find keymaps" })
keymap("n", "<leader>fb", "<CMD>FzfLua builtin<CR>", { desc = "Find Builtin FZF" })
keymap("n", "<leader><leader>", "<CMD>FzfLua buffers<CR>", { desc = "Find existing buffers" })
keymap("n", "<leader>/", "<CMD>FzfLua live_grep<CR>", { desc = "Live grep current buffer" })

keymap("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer keymaps (which-key)" })
  
keymap({ "n", "v" }, "<leader>e", "<CMD>Neotree filesystem toggle left<CR>", { desc = "Neo-tree toggle" })

keymap("t", "<ESC>", [[<C-\><C-n>]])
keymap("n", "<leader>T", "<CMD>ToggleTerm<CR>", { desc = "Toggle Terminal" })

keymap("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "Hover" })

keymap("n", "<leader>fa", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format" })

keymap("n", "<leader>k", '<CMD>lua require("kubectl").toggle()<CR>')

keymap({"n","v" }, "<leader>F", "<CMD>filetype detect<CR>", { desc = "Filetype detect"})
