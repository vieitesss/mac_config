-- Run File
vim.keymap.set("n", "<Leader>rf", "<cmd>RunCode<CR>", { silent = true })

local status, cr = pcall(require, "code_runner")
if not status then
	return
end

cr.setup({
	startinsert = true,
	term = {
		size = 50,
		position = "vert botright",
	},
	filetype = {
		python = "python3 $file",
		java = "cd $dir && javac $fileName && java $fileNameWithoutExt && rm $fileNameWithoutExt.class",
		c = "cd $dir && make -f ~/.mac_config/makefiles/c/Makefile target=$fileNameWithoutExt && make -f ~/.mac_config/makefiles/c/Makefile clean",
	},
})
