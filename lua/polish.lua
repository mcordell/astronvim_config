-- Base path text (readable but not “matchy”)
vim.api.nvim_set_hl(0, "SnacksPickerPath", { fg = "#D8DEE9" })
vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#D8DEE9" })

-- Matched characters (make them pop)
vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = "#EBCB8B", bold = true })
vim.api.nvim_set_hl(0, "SnacksPickerMatchBold", { fg = "#EBCB8B", bold = true }) -- some versions use this
vim.api.nvim_set_hl(0, "SnacksPickerMatchUnderline", { fg = "#EBCB8B", underline = true })
-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
