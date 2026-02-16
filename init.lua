vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 4
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.tabstop = 3
vim.o.swapfile = false
vim.o.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.o.winborder = "rounded"

--sourcing
vim.keymap.set('n', '<leader>o', ':update<CR>:source<CR>')
--writing
vim.keymap.set('n', '<leader>w', ':write<CR>')
--quit shortcut
vim.keymap.set('n', '<leader>q', ':quit<CR>')

--vs studio like ctrl+d  line doubleing
vim.keymap.set('n', '<leader>d', 'yyp', { noremap = true })
vim.keymap.set('v', '<leader>d', ":t '>\n<CR>", { noremap = true, silent = true })

-- plugins
vim.pack.add({
	{ src = "https://github.com/morhetz/gruvbox.git" },
	{ src = "https://github.com/stevearc/oil.nvim.git" },
	{ src = "https://github.com/echasnovski/mini.pick.git" },
	{ src = "https://github.com/neovim/nvim-lspconfig.git" },
	{ src = "https://github.com/williamboman/mason.nvim.git" },
	{ src = "https://github.com/williamboman/mason-lspconfig.nvim.git" },
}, { load = true })  

vim.pack.add({ { src = "https://github.com/chomosuke/typst-preview.nvim.git" } }, { load = true })
require("typst-preview").setup()


vim.api.nvim_create_autocmd('LspAttach',{
	 callback = function(ev)
		  local client = vim.lsp.get_client_by_id(ev.data.client_id)
		  if client:supports_method('textDocument/completion') then
				vim.lsp.completion.enable(true,client.id,ev.buf, {autotrigger = true})
		  end
	 end,
})
vim.cmd("set completeopt+=noselect")
--idk I might change the colorscheme tho
vim.cmd("colorscheme gruvbox")

--language servers
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { 
        "lua_ls",        -- Lua
        "clangd",        -- C, C++
        "jdtls",         -- Java
        "omnisharp",     -- C#
    }
})


require("mini.pick").setup()
require("oil").setup()
require("typst-preview").setup()

--vim.lsp.config("lua_ls", {})
vim.lsp.enable({"lua_ls","clangd","jdtls","omnisharp"})

--search file
vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
--help
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
--oil
vim.keymap.set('n', '<leader>e', ":Oil<CR>")
--typst inspect
vim.keymap.set('n', '<leader>tp', ":TypstPreview<CR>", { noremap = true, silent = true })
vim.cmd(":hi statusline guibg=NONE")

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
