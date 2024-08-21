-- normal options
vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true

-- reassign leader keys
vim.g.mapleader = " "

-- remap movement
vim.keymap.set({"n", "v", "o"}, 'j', '<Left>')
vim.keymap.set({"n", "v", "o"}, 'k', '<Down>')
vim.keymap.set({"n", "v", "o"}, 'l', '<Up>')
vim.keymap.set({"n", "v", "o"}, ';', '<Right>')

-- faster scrolling
vim.keymap.set({"n", "v", "o"}, 'K', '5<Down>')
vim.keymap.set({"n", "v", "o"}, 'L', '5<Up>')

-- window switch remap
vim.keymap.set({"n", "v", "o"}, '<C-w><C-j>', '<C-w>h')
vim.keymap.set({"n", "v", "o"}, '<C-w><C-k>', '<C-w>j')
vim.keymap.set({"n", "v", "o"}, '<C-w><C-l>', '<C-w>k')
vim.keymap.set({"n", "v", "o"}, '<C-w><C-;>', '<C-w>l')

-- faster window creation
vim.keymap.set("n", "<leader>h", ":wincmd v<cr>:wincmd l<cr>")
vim.keymap.set("n", "<leader>v", ":wincmd s<cr>:wincmd j<cr>")

-- remap end of line
vim.keymap.set({"n", "v", "o"}, '-', '$')
vim.keymap.set({"n", "v", "o"}, 'd-', 'd$')

-- remap exit mode
vim.keymap.set({"i", "v", "o"}, "fj", "<ESC>")

-- yank & paste from system clipboard by default
vim.cmd("set clipboard+=unnamedplus")

-- initialize lazy.nvim
require("config.lazy")

-- map file browser
vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")

-- melange theme settings
vim.opt.termguicolors = true
vim.cmd.colorscheme 'melange'

-- configure lsp
local lsp_zero = require("lsp-zero")
lsp_zero.extend_lspconfig()

lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({buffer = bufnr})
end)

-- enable snippets and configure keybinds
require("luasnip.loaders.from_vscode").lazy_load()

local ls = require("luasnip")

ls.config.set_config {
	history = true,
	updateevents = "TextChanged,TextChangedI"
}

local cmp = require("cmp")
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping(function(fallback)
        	if cmp.visible() then
            	if ls.expandable() then
                	ls.expand()
            	else
                	cmp.confirm({
                    	select = true,
                	})
            	end
        	else
            	fallback()
        	end
    	end),

	    ["<Tab>"] = cmp.mapping(function(fallback)
	      if cmp.visible() then
	        cmp.select_next_item()
	      elseif ls.locally_jumpable(1) then
	        ls.jump(1)
	      else
	        fallback()
	      end
	    end, { "i", "s" }),

	    ["<S-Tab>"] = cmp.mapping(function(fallback)
	      if cmp.visible() then
	        cmp.select_prev_item()
	      elseif ls.locally_jumpable(-1) then
	        ls.jump(-1)
	      else
	        fallback()
	      end
	    end, { "i", "s" }),

		-- navigate snipper placeholders
		['<C-l>'] = cmp_action.luasnip_jump_forward(),
    	['<C-k>'] = cmp_action.luasnip_jump_backward(),
	}),
	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body)
		end
	}
})
