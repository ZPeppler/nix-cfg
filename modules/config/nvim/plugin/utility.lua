-- sshfs
require("sshfs").setup({
	ui = {
		preferred_picker = "neo-tree",
	},
})

-- kubectl.nvim
require("kubectl").setup()
vim.api.nvim_create_autocmd("FileType", {
	pattern = "k8s_*",
	callback = function()
		vim.keymap.set("n", "7", "<Plug>(kubectl.view_nodes)", {
			buffer = true,
		})
		vim.keymap.set("n", "8", "<Plug>(kubectl.view_overview)", {
			buffer = true,
		})
		vim.keymap.set("n", "<C-k>", "<Plug>(kubectl.kill)", {
			buffer = true,
		})
		vim.keymap.set("n", "<C-t>", "<Plug>(kubectl.view_top)", {
			buffer = true,
		})
	end,
})

-- persistence 
require("persistence").setup({
  dir = vim.fn.stdpath("state") .. "/sessions/",
  options = { "buffers", "curdir", "options", "tabpages", "winsize" },
  pre_save = function()
    local cwd = vim.fn.getcwd()
    if cwd == vim.fn.expand("~") or cwd:match("/tmp") then
      return false
    end
  end,
})
