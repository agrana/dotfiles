--
--
-- Common vim options o
-- 
--

vim.o.number = true
vim.g.mapleader = " "
vim.g.loaded_ruby_provider = 0

--
--
-- Plugin Installation with built in pack.
--

vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.pick", version = "main" },
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/nvim-mini/mini.icons" },
	{ src = "https://github.com/m4xshen/autoclose.nvim" },
	{ src = "https://github.com/hedyhli/outline.nvim", keys = "<leader>p"},
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/lukas-reineke/headlines.nvim" }
})

vim.cmd("packadd nvim-treesitter")
vim.cmd("packadd headlines.nvim")
-- Mini Pick Browser
require('mini.pick').setup({})

-- Mini Icons
require('mini.icons').setup({})

-- Map <leader>p to open the MiniPick UI
vim.keymap.set('n', '<leader>p', function()
    -- This Lua function calls the open() method from the MiniPick module
    require('mini.pick').builtin.files()
end, { desc = "Open Mini Picker" })

local function toggle_terminal()
	local current_buf = vim.api.nvim_get_current_buf()
	if vim.bo[current_buf].buftype == "terminal" then
		vim.cmd("stopinsert")
		vim.cmd("wincmd p")
		return
	end

	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].buftype == "terminal" then
			vim.api.nvim_set_current_win(win)
			vim.cmd("startinsert")
			return
		end
	end

	vim.cmd("botright 15split")
	vim.cmd("terminal")
	vim.cmd("startinsert")
end

vim.keymap.set('n', '<leader>t', toggle_terminal, { desc = "Toggle terminal" })
vim.keymap.set('t', '<C-t>', [[<C-\><C-n><C-w>p]], { desc = "Toggle terminal" })

-- Catpuccin configuration
require("catppuccin").setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = true, -- disables setting the background color.
    float = {
        transparent = false, -- enable transparent floating windows
        solid = false, -- use solid styling for floating windows, see |winborder|
    },
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
        virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
        },
        underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
        },
        inlay_hints = {
            background = true,
        },
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    auto_integrations = false,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
    },
})
-- Set color scheme
vim.cmd.colorscheme "catppuccin"

-- Load autoclose
require("autoclose").setup()

require("outline").setup({
	outline_window = {
		no_provider_message = "",
	},
})

local has_treesitter, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if has_treesitter then
	treesitter_configs.setup({
		highlight = { enable = true },
	})
end

vim.api.nvim_set_hl(0, "Headline1", { fg = "white", bg = "#1e0b7d" })
vim.api.nvim_set_hl(0, "Headline2", { fg = "white", bg = "#0038a8" })
vim.api.nvim_set_hl(0, "Headline3", { fg = "white", bg = "#007fff" })
vim.api.nvim_set_hl(0, "Headline4", { fg = "white", bg = "#0892e0" })
vim.api.nvim_set_hl(0, "Headline5", { fg = "white", bg = "#9d00ff" })
vim.api.nvim_set_hl(0, "Headline6", { fg = "white", bg = "#f900ff" })
vim.api.nvim_set_hl(0, "CodeBlock", { bg = "#09090d" })
vim.api.nvim_set_hl(0, "Dash", { fg = "white" })

local has_headlines, headlines = pcall(require, "headlines")
if has_headlines then
	headlines.setup({
		markdown = {
			fat_headlines = true,
			fat_headline_upper_string = "▄",
			fat_headline_lower_string = "▀",
			headline_highlights = {
				"Headline1",
				"Headline2",
				"Headline3",
				"Headline4",
				"Headline5",
				"Headline6",
			},
		},
	})
end
