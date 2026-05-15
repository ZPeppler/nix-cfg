-- neovide
if vim.g.neovide then
	vim.env.NEOVIDE = "1"
	vim.opt.guifont = "JetBrainsMono Nerd Font:h12.5"
	vim.g.neovide_cursor_animation_length = 0.06
	vim.g.neovide_cursor_trail_length = 0.8
	vim.g.neovide_cursor_antialiasing = true
	-- Zoom factor
	vim.g.neovide_scale_factor = 1.0
	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end
	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(1.25)
	end, { desc = "Zoom In" })
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / 1.25)
	end, { desc = "Zoom Out" })

	-- Smooth scrolling
	vim.g.neovide_scroll_animation_length = 0.3

	-- Hide mouse when typing
	vim.g.neovide_hide_mouse_when_typing = true
end
