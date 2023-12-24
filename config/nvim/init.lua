-- h/t John Kaczor for the initial version of this file: https://raw.githubusercontent.com/johngkhs/dotfiles/master/nvim/init.lua

----------------------------------------------------------------------------------------------------------------
--                                                paq                                                         --
----------------------------------------------------------------------------------------------------------------

local PACKAGES = {
	"savq/paq-nvim",

	"elihunter173/dirbuf.nvim",
	"ibhagwan/fzf-lua",
	"lewis6991/gitsigns.nvim",
	"morhetz/gruvbox",
	"nvim-lua/plenary.nvim",
	"ojroques/nvim-hardline",
	"tpope/vim-fugitive",
	"tpope/vim-repeat",

	"AndrewRadev/sideways.vim",
	"PeterRincker/vim-argumentative",
	"RRethy/vim-illuminate",
	"embear/vim-foldsearch",
	"gbprod/substitute.nvim",
	"ggandor/flit.nvim",
	"ggandor/leap.nvim",
	"johngkhs/quickfix-reflector.vim",
	"johngkhs/vim-textobj-variable-segment",
	"kana/vim-altr",
	"kana/vim-textobj-user",
	"machakann/vim-sandwich",
	"milkypostman/vim-togglelist",
	"terrortylor/nvim-comment",
	"tpope/vim-abolish",

	"filipdutescu/renamer.nvim",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"hrsh7th/cmp-path",
	"hrsh7th/nvim-cmp",
	"hrsh7th/vim-vsnip",
	"hrsh7th/vim-vsnip-integ",
	"j-hui/fidget.nvim",
	"m-pilia/vim-ccls",
	"mfussenegger/nvim-dap",
	"mfussenegger/nvim-lint",
	"mhartington/formatter.nvim",
	"neovim/nvim-lspconfig",
	"nvim-treesitter/nvim-treesitter",
	"rafamadriz/friendly-snippets",
	"rcarriga/nvim-dap-ui",
}

local function bootstrap_paq()
	local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
	if vim.fn.empty(vim.fn.glob(path)) > 0 then
		vim.fn.system({ "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", path })
		vim.cmd("packadd paq-nvim")
		require("paq")(PACKAGES).install()
	end
end

bootstrap_paq()
require("paq")(PACKAGES)

----------------------------------------------------------------------------------------------------------------
--                                             functions                                                      --
----------------------------------------------------------------------------------------------------------------

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

----------------------------------------------------------------------------------------------------------------
--                                          general settings                                                  --
----------------------------------------------------------------------------------------------------------------

vim.g.mapleader = " "
vim.api.nvim_set_option("clipboard", "unnamedplus")
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.hidden = false
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case --column --line-number"

vim.opt.background = "dark"
-- vim.opt.termguicolors = true
vim.cmd([[colorscheme gruvbox]])

----------------------------------------------------------------------------------------------------------------
--                                          general mappings                                                  --
----------------------------------------------------------------------------------------------------------------

map("n", ";", ":")
map("v", ";", ":")

map("v", "<tab>", ">gv")
map("v", "<s-tab>", "<gv")
map("n", "<tab>", ">>")
map("n", "<s-tab>", "<<")

map("c", "jk", "<c-c>")

map("n", "J", "20j")
map("n", "K", "20k")
map("v", "J", "20j")
map("v", "K", "20k")

map("n", "<leader>w", "<cmd>w<cr>")
map("n", "<leader><leader>w", "<cmd>wa<cr>")
map("n", "<leader>q", "<cmd>q<cr>")
map("n", "<leader><leader>q", "<cmd>qa!<cr>")

map("n", "H", "<c-o>")
map("n", "L", "<c-i>")

-- Substitution or rename keymaps
map("n", "<leader>r", ":%s@<c-r><c-w>@@gcI<left><left><left><left>")
map("v", "<leader>r", 'y:%s@<C-r>"@@gcI<left><left><left><left>')

map("n", "<leader>R", ":%s@\b<c-r><c-w>\b@@gI<left><left><left>")
map("v", "<leader>R", 'y:%s@<C-r>"@@gI<left><left><left>')

-- Join two lines
map("n", "<leader>j", "mzJ`z")

map("n", "<leader>E", ":vsplit $MYVIMRC<cr>")
map("n", "<leader>S", ":source $MYVIMRC<cr>")

map("n", "<leader>d", '"_d')
map("x", "<leader>d", '"_d')
map("n", "<leader>dd", '"_dd')
map("x", "<leader>dd", '"_dd')
map("n", "<leader>c", '"_c')
map("x", "<leader>c", '"_c')

----------------------------------------------------------------------------------------------------------------
--                                             hardline                                                       --
----------------------------------------------------------------------------------------------------------------

require("hardline").setup({})

----------------------------------------------------------------------------------------------------------------
--                                          nvim-treesitter                                                   --
----------------------------------------------------------------------------------------------------------------

require("nvim-treesitter.configs").setup({
	ensure_installed = { "vim", "lua", "cpp", "python" },
	highlight = { enable = true },
})

----------------------------------------------------------------------------------------------------------------
--                                             renamer                                                        --
----------------------------------------------------------------------------------------------------------------

require("renamer").setup({})

map("n", "<leader><leader>r", '<cmd>lua require("renamer").rename({ empty = true })<cr>', { silent = true })
map("v", "<leader><leader>r", '<cmd>lua require("renamer").rename({ empty = true })<cr>', { silent = true })

----------------------------------------------------------------------------------------------------------------
--                                            illuminate                                                      --
----------------------------------------------------------------------------------------------------------------

require("illuminate").configure({ delay = 0 })

----------------------------------------------------------------------------------------------------------------
--                                             gitsigns                                                       --
----------------------------------------------------------------------------------------------------------------

require("gitsigns").setup({})

----------------------------------------------------------------------------------------------------------------
--                                              fzf-lua                                                       --
----------------------------------------------------------------------------------------------------------------

require("fzf-lua").setup({
	winopts = {
		fullscreen = true,
		preview = { layout = "vertical", vertical = "up:45%" },
	},
	fzf_opts = {
		["-m --bind"] = "ctrl-a:toggle-all",
	},
})

map("n", "<enter>", '<cmd>lua require("fzf-lua").lsp_definitions({ jump_to_single_result = true })<cr>')
map("n", "<leader>f", "<cmd>FzfLua files<cr>")
map("n", "<leader>b", "<cmd>FzfLua buffers<cr>")
map("n", "<leader>s", "<cmd>FzfLua grep_cword<cr>")
map("n", "<leader>t", "<cmd>FzfLua grep<cr>")
map("n", "<leader><leader>s", "<cmd>FzfLua lsp_references<cr>")
map("n", "<leader><leader>a", "<cmd>FzfLua grep_last<cr>")
map("n", "<leader>g", "<cmd>FzfLua lsp_live_workspace_symbols<cr>")
map("n", "<leader><leader>g", "<cmd>FzfLua live_grep_native<cr>")
map("n", "<leader><leader>f", '<cmd>lua require("fzf-lua").lsp_code_actions({ winopts = { fullscreen = false } })<cr>')

----------------------------------------------------------------------------------------------------------------
--                                                 formatter.nvim                                             --
----------------------------------------------------------------------------------------------------------------

local formatter_nvim_utils = require("formatter.util")
require("formatter").setup({
	filetype = {
		bzl = {
			function()
				return {
					exe = "buildifier",
					args = {
						"-path",
						formatter_nvim_utils.escape_path(formatter_nvim_utils.get_current_buffer_file_name()),
					},
					stdin = true,
				}
			end,
		},
		cpp = {
			function()
				return {
					exe = "clang-format",
					args = {
						"--assume-filename",
						formatter_nvim_utils.escape_path(formatter_nvim_utils.get_current_buffer_file_path()),
						"--style=file",
					},
					stdin = true,
				}
			end,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		ocaml = {
			function()
				return {
					exe = "ocamlformat",
					args = {
						"--enable-outside-detected-project",
						"--name",
						formatter_nvim_utils.escape_path(formatter_nvim_utils.get_current_buffer_file_path()),
						"-",
					},
					stdin = true,
				}
			end,
		},
		py = {
			require("formatter.filetypes.python").black,
		},
		rust = {
			require("formatter.filetypes.rust").rustfmt,
		},
		swift = {
			function()
				return {
					exe = "swiftformat",
					args = {
						"--stdinpath",
						formatter_nvim_utils.escape_path(formatter_nvim_utils.get_current_buffer_file_path()),
						"stdin",
					},
					stdin = true,
				}
			end,
		},
	},
})

vim.api.nvim_create_augroup("__formatter__", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})

----------------------------------------------------------------------------------------------------------------
--                                              nvim-lint                                                     --
----------------------------------------------------------------------------------------------------------------

local shellcheck_linter = require("lint").linters.shellcheck
require("lint").linters.shellcheck_for_zsh = vim.tbl_extend("force", shellcheck_linter, {
	-- Zsh is not supported, and Bash is close enough.
	args = vim.list_extend({ "--shell=bash" }, shellcheck_linter.args),
})

local luacheck_linter = require("lint").linters.luacheck
require("lint").linters.luacheck_for_mac = vim.tbl_extend("force", luacheck_linter, {
	args = vim.list_extend({ "--default-config=/Users/nick/.config/luacheck/.luacheckrc" }, luacheck_linter.args),
})

require("lint").linters_by_ft = {
	bzl = { "buildifier" },
	lua = { "luacheck_for_mac" },
	py = { "flake8" },
	sh = { "shellcheck" },
	vim = { "vint" },
	yaml = { "yamllint" },
	zsh = { "shellcheck_for_zsh" },
}

vim.api.nvim_create_augroup("__linter__", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = "__linter__",
	callback = function()
		require("lint").try_lint()
	end,
})

----------------------------------------------------------------------------------------------------------------
--                                          lspconfig and nvim-cmp                                            --
----------------------------------------------------------------------------------------------------------------

require("cmp_nvim_lsp_signature_help")
vim.opt.completeopt = { "menu", "menuone", "noselect" }

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local servers = { "ccls", "pyright", "rust_analyzer", "ocamllsp" }
local lspconfig = require("lspconfig")
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		capabilities = capabilities,
	})
end

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<cr>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
		["<c-space>"] = cmp.mapping.complete(),
		["<tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<s-tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp", group_index = 1 },
		{ name = "vsnip", group_index = 1 },
		{ name = "buffer", group_index = 2 },
		{ name = "nvim_lsp_signature_help", group_index = 3 },
		{ name = "path", group_index = 4 },
	}),
})

map("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float({focus = false})<cr>")
map("n", "<leader>i", "<cmd>lua vim.lsp.buf.hover()<cr>")

----------------------------------------------------------------------------------------------------------------
--                                            nvim-comment                                                    --
----------------------------------------------------------------------------------------------------------------

require("nvim_comment").setup({ create_mappings = false })
vim.cmd('autocmd BufEnter *.cpp,*.h :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")')
map("n", "<leader>,", ":CommentToggle<cr>")
map("v", "<leader>,", ":'<,'>CommentToggle<cr>")

----------------------------------------------------------------------------------------------------------------
--                                           leap and flit                                                    --
----------------------------------------------------------------------------------------------------------------

require("leap").add_default_mappings()
require("flit").setup({})

----------------------------------------------------------------------------------------------------------------
--                                         substitute.nvim                                                    --
----------------------------------------------------------------------------------------------------------------

require("substitute").setup({})
vim.keymap.set("n", "sx", require("substitute.exchange").operator)
vim.keymap.set("n", "sxx", require("substitute.exchange").line)
vim.keymap.set("x", "X", require("substitute.exchange").visual)
vim.keymap.set("n", "sxc", require("substitute.exchange").cancel)

----------------------------------------------------------------------------------------------------------------
--                                           dirbuf.nvim                                                      --
----------------------------------------------------------------------------------------------------------------

require("dirbuf").setup({})
map("n", "<leader>-", "<cmd>DirbufQuit<cr>")

----------------------------------------------------------------------------------------------------------------
--                                              vim-altr                                                      --
----------------------------------------------------------------------------------------------------------------

vim.cmd(
	[[call altr#define('%/main.cpp',  '%/util/types.h', '%/detail/types.cpp', '%/detail/args.h', '%/detail/args.cpp', '%/detail/app.h', '%/detail/app.cpp', '%/ut/app_test.cpp')]]
)
vim.cmd([[call altr#define('%/%.h', '%/priv/%.h', '%/%.cpp', '%/ut/%_test.cpp', '%/ut/%_slow_test.cpp')]])
vim.cmd([[call altr#define('%.h', '%.cpp')]])
map("n", "<leader>.", "<cmd>call altr#forward()<cr>")
map("n", "<leader>/", "<cmd>call altr#back()<cr>")

----------------------------------------------------------------------------------------------------------------
--                                             nvim-dap                                                       --
----------------------------------------------------------------------------------------------------------------

local dap = require("dap")
dap.adapters.lldb = {
	type = "executable",
	command = "</path/to/lldb-vscode>",
	name = "lldb",
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = vim.fn.getcwd() .. "/a.out",
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = { "-enable-pretty-printing" },
		runInTerminal = false,
	},
}

require("dapui").setup({
	layouts = {
		{
			elements = { "scopes" },
			size = 0.35,
			position = "left",
		},
		{
			elements = { "repl" },
			size = 0.35,
			position = "bottom",
		},
	},
})

map("n", "<leader><leader>l", "<cmd>DapContinue<cr>")
map("n", "<leader><leader>j", "<cmd>DapStepOver<cr>")
map("n", "<leader><leader>k", "<cmd>DapStepInto<cr>")
map("n", "<leader><leader>t", "<cmd>DapTerminate<cr>")
map("n", "<leader><leader>b", "<cmd>DapToggleBreakpoint<cr>")
map("n", "<leader><leader>p", '<cmd>lua require("dapui").toggle()<cr>')

----------------------------------------------------------------------------------------------------------------
--                                              cppman                                                        --
----------------------------------------------------------------------------------------------------------------

function cppman_lookup()
	local word = vim.api.nvim_call_function("expand", { "<cword>" })
	vim.api.nvim_command("botright vnew")
	local columns = vim.api.nvim_win_get_width(0) - 2
	vim.api.nvim_command("read !cppman --force-columns=" .. columns .. " " .. word)
	vim.api.nvim_command("setlocal ft=man nomod ro")
end

map("n", "<leader><leader>i", "<cmd>lua cppman_lookup()<cr>gg", { silent = true })

----------------------------------------------------------------------------------------------------------------
--                                              fidget                                                        --
----------------------------------------------------------------------------------------------------------------

require("fidget").setup({})

----------------------------------------------------------------------------------------------------------------
--                                           vim-togglelist                                                   --
----------------------------------------------------------------------------------------------------------------

vim.g.toggle_list_no_mappings = true
map("n", "<leader>a", "<cmd>call ToggleQuickfixList()<cr>")
vim.cmd("autocmd FileType qf wincmd J")
vim.cmd("autocmd FileType qf set winheight=30")

----------------------------------------------------------------------------------------------------------------
--                                            sideways.vim                                                    --
----------------------------------------------------------------------------------------------------------------

map("n", "<leader><left>", "<cmd>SidewaysLeft<cr>")
map("n", "<leader><right>", "<cmd>SidewaysRight<cr>")
