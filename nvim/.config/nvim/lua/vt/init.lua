require("vt/plugins")
require("vt/keymaps")
require("vt/configs")

P = function(v)
	print(vim.inspect(v))
	return v
end

if pcall(require, "plenary") then
    RELOAD = require("plenary.reload").reload_module

    R = function(name)
        RELOAD(name)
        return require(name)
    end
end


-- Status line
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.api.nvim_command("set laststatus=3")
	end,
})

-- Latex autocmd save and compile .tex
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.tex",
    callback = function ()
        dir = vim.fn.expand("%:p:h")
        file = vim.fn.expand("%")
        -- print(":silent ! latexmk -f -shell-escape -cd -pdf " .. vim.fn.expand("%:p") .. " > /dev/null")
        vim.cmd(":silent ! cd " .. dir .. " && latexmk -f -shell-escape -pdf ./" .. file)
    end
})

OPENPDFVIEWER = function()
    -- Get file path without extension
    path_no_ext = vim.fn.expand("%:p:r")
    -- Check if Skim is open, if open, check opened file, if not open, open current file
    skim_is_open = io.popen("ps aux | grep Skim | grep -cv grep")
    skim_is_open_result = skim_is_open:read("*a")
    if string.sub(skim_is_open_result, 1, 1) ~= '0' then
        -- Check if the current file is opened with Skim
        handle = io.popen("lsof -p $(ps aux | grep Skim | grep -v grep | awk '{print $2}') | grep -c " ..  path_no_ext .. ".pdf")
        result = handle:read("*a")
        -- Open this file if not opened
        if string.sub(result, 1, 1) == '0' then
            os.execute("open " .. path_no_ext .. ".pdf -a Skim")
        end
        handle:close()
    else
        os.execute("open " .. path_no_ext .. ".pdf -a Skim")
    end
    skim_is_open:close()
end

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = { "*.js", "*.c", "*.h", "*.lua", "*.sh", "*.java" },
-- 	callback = function()
-- 		vim.lsp.buf.format()
-- 	end,
-- })
