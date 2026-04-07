-- h/t John Kaczor for the initial version of this file: https://raw.githubusercontent.com/johngkhs/dotfiles/master/nvim/init.lua

----------------------------------------------------------------------------------------------------------------
--                                                paq                                                         --
----------------------------------------------------------------------------------------------------------------

local PACKAGES = {
	"savq/paq-nvim",

	"KenN7/vim-arsync",
	"elihunter173/dirbuf.nvim",
	"ellisonleao/gruvbox.nvim",
	"ibhagwan/fzf-lua",
	"lewis6991/gitsigns.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-tree.lua",
	"ojroques/nvim-hardline",
	"prabirshrestha/async.vim",
	"sindrets/winshift.nvim",
	"tpope/vim-fugitive",
	"tpope/vim-repeat",

	"AndrewRadev/sideways.vim",
	"PeterRincker/vim-argumentative",
	"RRethy/vim-illuminate",
	"easymotion/vim-easymotion",
	"embear/vim-foldsearch",
	"gbprod/substitute.nvim",
	"johngkhs/quickfix-reflector.vim",
	"johngkhs/vim-textobj-variable-segment",
	"kana/vim-altr",
	"kana/vim-textobj-user",
	"machakann/vim-sandwich",
	"pianohacker/vim-textobj-indented-paragraph",
	"terrortylor/nvim-comment",
	"tpope/vim-abolish",

	"filipdutescu/renamer.nvim",
	"greggh/claude-code.nvim",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"hrsh7th/cmp-path",
	"hrsh7th/nvim-cmp",
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
	"saadparwaiz1/cmp_luasnip",
	"j-hui/fidget.nvim",
	"lervag/vimtex",
	"mfussenegger/nvim-ansible",
	"mfussenegger/nvim-lint",
	"mhartington/formatter.nvim",
	"micangl/cmp-vimtex",
	"neovim/nvim-lspconfig",
	"nvim-treesitter/nvim-treesitter",
}

local PAQS_PATH = vim.fn.stdpath("data") .. "/site/pack/paqs"

local function bootstrap_paq()
	local path = PAQS_PATH .. "/start/paq-nvim"
	if vim.fn.empty(vim.fn.glob(path)) > 0 then
		vim.fn.system({ "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", path })
		vim.cmd("packadd paq-nvim")
	end
end

bootstrap_paq()
require("paq"):setup({ path = PAQS_PATH .. "/" })(PACKAGES)

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

-- Disable netrw per nvim-tree.lua's suggestion.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.background = "dark"

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
--                                      plugin-driven settings                                                --
----------------------------------------------------------------------------------------------------------------

vim.cmd([[colorscheme gruvbox]])

----------------------------------------------------------------------------------------------------------------
--                                             hardline                                                       --
----------------------------------------------------------------------------------------------------------------

local hardline_defaults = require("hardline").options
local hardline_sections = vim.deepcopy(hardline_defaults.sections)
table.insert(hardline_sections, 2, { class = "med", item = require("hardline.parts.cwd").get_item })
require("hardline").setup({ sections = hardline_sections })

----------------------------------------------------------------------------------------------------------------
--                                    LuaSnip/friendly-snippets                                               --
----------------------------------------------------------------------------------------------------------------
require("luasnip.loaders.from_vscode").lazy_load()

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("json", {
	s("pyright-pypy", t('{"venvPath": ".", "venv": ".venv", "extraPaths": [".venv/lib/pypy3.10/site-packages"]}')),
})

ls.add_snippets("toml", {
	s(
		"uv-acl",
		t({
			"[tool.uv.sources]",
			'ac-library-python = { git = "https://github.com/not522/ac-library-python", rev = "27fdbb71cd0d566bdeb12746db59c9d908c6b5d5" }',
		})
	),
	s(
		"uv-system",
		t({
			"[tool.uv]",
			'python-preference = "only-system"',
		})
	),
})

----------------------------------------------------------------------------------------------------------------
--                                           nvim-tree.lua                                                    --
----------------------------------------------------------------------------------------------------------------

require("nvim-tree").setup({})

map("n", "<leader>h", "<cmd>NvimTreeFindFile<cr>")

----------------------------------------------------------------------------------------------------------------
--                                          nvim-treesitter                                                   --
----------------------------------------------------------------------------------------------------------------

require("nvim-treesitter").install({ "vim", "lua", "cpp", "python", "rust" })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "vim", "lua", "cpp", "python", "rust" },
	callback = function()
		vim.treesitter.start()
	end,
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
	lsp = {
		symbols = {
			child_prefix = true,
			parent_postfix = ".",
		},
	},
})

function fzf_plugin_lua_files()
	require("fzf-lua").fzf_exec(
		"find " .. PAQS_PATH .. " -type f -name '*.lua'",
		{ actions = require("fzf-lua").defaults.actions.files }
	)
end

map("n", "<enter>", '<cmd>lua require("fzf-lua").lsp_definitions({ jump1 = true })<cr>')
map("n", "<leader>f", "<cmd>FzfLua files<cr>")
map("n", "<leader>b", "<cmd>FzfLua buffers<cr>")
map("n", "<leader>s", "<cmd>FzfLua grep_cword<cr>")
map("n", "<leader>t", "<cmd>FzfLua grep<cr>")
map("n", "<leader><leader>s", "<cmd>FzfLua lsp_references<cr>")
map("n", "<leader><leader>a", "<cmd>FzfLua grep_last<cr>")
map("n", "<leader>g", "<cmd>FzfLua lsp_live_workspace_symbols<cr>")
map("n", "<leader><leader>g", "<cmd>FzfLua live_grep_native<cr>")
map("n", "<leader><leader>f", '<cmd>lua require("fzf-lua").lsp_code_actions({ winopts = { fullscreen = false } })<cr>')
map("n", "<leader>p", "<cmd>lua fzf_plugin_lua_files()<cr>")
map("n", "<leader>o", "<cmd>FzfLua lsp_document_symbols<cr>")

----------------------------------------------------------------------------------------------------------------
--                                                 formatter.vim                                              --
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
		python = {
			require("formatter.filetypes.python").black,
		},
		rust = {
			function()
				return {
					exe = "rustfmt",
					args = {
						"--edition=2024",
					},
					stdin = true,
				}
			end,
		},
		go = {
			require("formatter.filetypes.go").gofmt,
			require("formatter.filetypes.go").goimports,
		},
		cmake = {
			require("formatter.filetypes.cmake").cmakeformat,
		},
		toml = {
			function()
				return {
					exe = "tombi",
					args = { "format", "-" },
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

require("lint").linters_by_ft = {
	bzl = { "buildifier" },
	lua = { "luacheck" },
	py = { "flake8" },
	sh = { "shellcheck" },
	vim = { "vint" },
	toml = { "tombi" },
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
--                                         lsp config and nvim-cmp                                            --
----------------------------------------------------------------------------------------------------------------

require("cmp_nvim_lsp_signature_help")
vim.opt.completeopt = { "menu", "menuone", "noselect" }

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local servers = { "clangd", "pyright", "rust_analyzer", "ansiblels" }
require("lspconfig")
for _, server in ipairs(servers) do
	vim.lsp.config(server, {
		capabilities = capabilities,
	})
end
vim.lsp.enable(servers)

local cmp = require("cmp")

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<cr>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
		["<c-space>"] = cmp.mapping.complete(),
		["<tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<s-tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() and has_words_before() then
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
		{ name = "vimtex", group_index = 1 },
		{ name = "luasnip", group_index = 1 },
		{ name = "buffer", group_index = 2 },
		{ name = "nvim_lsp_signature_help", group_index = 3 },
		{ name = "path", group_index = 4 },
	}),
})

map("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float({focus = false})<cr>")
map("n", "<leader>i", "<cmd>lua vim.lsp.buf.hover()<cr>")

-- Prevent accidental writing after, e.g., LSP jumps.
local third_party_packages_read_only_group = vim.api.nvim_create_augroup("ThirdPartyPackagesReadOnly", { clear = true })
for _, pattern in ipairs({
	os.getenv("HOME") .. "/.local/share/nvim/*",
	-- Pyright system stubs, Go system source, etc., e.g.,  /opt/homebrew/Cellar/pyright/1.1.388/libexec/*
	"/opt/homebrew/Cellar/*/*/libexec/*",
	os.getenv("HOME") .. "/Library/Caches/pypoetry/virtualenvs/*",
	os.getenv("HOME") .. "/.rustup/*",
	os.getenv("HOME") .. "/.cargo/*",
	os.getenv("HOME") .. "/.conan2/*",
	-- C/C++ system headers
	"/Applications/Xcode.app/*",
}) do
	vim.api.nvim_create_autocmd("BufRead", {
		group = third_party_packages_read_only_group,
		pattern = pattern,
		callback = function(ev)
			local buf = ev.buf
			vim.bo[buf].readonly = true
			vim.bo[buf].modifiable = false
		end,
	})
end

----------------------------------------------------------------------------------------------------------------
--                                            nvim-comment                                                    --
----------------------------------------------------------------------------------------------------------------

require("nvim_comment").setup({ create_mappings = false })
vim.cmd('autocmd BufEnter *.cpp,*.h :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")')
map("n", "<leader>,", ":CommentToggle<cr>")
map("v", "<leader>,", ":'<,'>CommentToggle<cr>")

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

require("fidget").setup({
	notification = {
		window = {
			align = "top",
		},
	},
	integration = {
		["nvim-tree"] = {
			enable = true,
		},
	},
})

----------------------------------------------------------------------------------------------------------------
--                                            sideways.vim                                                    --
----------------------------------------------------------------------------------------------------------------

map("n", "<leader><left>", "<cmd>SidewaysLeft<cr>")
map("n", "<leader><right>", "<cmd>SidewaysRight<cr>")

----------------------------------------------------------------------------------------------------------------
--                                            easymotion                                                      --
----------------------------------------------------------------------------------------------------------------

vim.g.EasyMotion_do_mapping = true
map("n", "\\", "<Plug>(easymotion-prefix)")

----------------------------------------------------------------------------------------------------------------
--                                      claude-code.nvim                                                      --
----------------------------------------------------------------------------------------------------------------
require("claude-code").setup()
