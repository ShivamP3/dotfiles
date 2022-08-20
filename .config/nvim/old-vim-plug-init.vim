" Line Numbers
:set number relativenumber

" 4-wide tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4
set noexpandtab

"
" Plugins
"
call plug#begin('~/.vim/plugged')
" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" rainbow parentheses
Plug 'p00f/nvim-ts-rainbow'
" show indent
Plug 'Yggdroot/indentLine'
" tabout
Plug 'abecodes/tabout.nvim'
" tidy whitespace
Plug 'mcauley-penney/tidy.nvim'
" vscode ui style renamer
Plug 'nvim-lua/plenary.nvim'
Plug 'filipdutescu/renamer.nvim', {'branch': 'master'}
" autosave
Plug 'Pocco81/AutoSave.nvim', {'branch': 'main'}
" comment
Plug 'numToStr/Comment.nvim'
" auto-pair
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'
" floating terminal
Plug 'numToStr/FTerm.nvim'
" git
Plug 'nvim-lua/plenary.nvim'
Plug 'tanvirtin/vgit.nvim', {'branch': 'main'}
Plug 'lewis6991/gitsigns.nvim', {'branch': 'main'}
Plug 'sindrets/diffview.nvim', {'branch': 'main'}
" CHAD filesystem
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
" statusline
Plug 'nvim-lualine/lualine.nvim'
" startup
Plug 'goolord/alpha-nvim', {'branch': 'main'}
" floating terminal
Plug 'numToStr/FTerm.nvim'

" Optional
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Autocompletion framework
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
" cmp LSP completion
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
" cmp Snippet completion
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
" cmp Path completion
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
" See hrsh7th other plugins for more great completion sources!

" Adds extra functionality over rust analyzer
Plug 'simrat39/rust-tools.nvim'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" color stuff
Plug 'RRethy/nvim-base16'
Plug 'adelarsq/vim-emoji-icon-theme'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
call plug#end()

" base16 color setup
let base16colorspace=256
colorscheme base16-gruvbox-dark-hard


" rainbow parentheses setup
lua <<EOF
     require("nvim-treesitter.configs").setup {
       rainbow = {
         enable = true,
         -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
         extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
         max_file_lines = nil, -- Do not enable for files with more than n lines, int
         -- colors = {}, -- table of hex strings
         -- termcolors = {} -- table of colour name strings
       }
     }
EOF

" renamer setup
inoremap <silent> <F2> <cmd>lua require('renamer').rename()<cr>
nnoremap <silent> <leader>rn <cmd>lua require('renamer').rename()<cr>
vnoremap <silent> <leader>rn <cmd>lua require('renamer').rename()<cr>

" tabout setup
lua <<EOF
    require('tabout').setup {
        tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        enable_backwards = true, -- well ...
        completion = true, -- if the tabkey is used in a completion pum
        tabouts = {
          {open = "'", close = "'"},
          {open = '"', close = '"'},
          {open = '`', close = '`'},
          {open = '(', close = ')'},
          {open = '[', close = ']'},
          {open = '{', close = '}'}
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {} -- tabout will ignore these filetypes
}
EOF

" comment setup
lua require('Comment').setup()

" git setup
lua require('vgit').setup()
lua require('gitsigns').setup()

" chadtree setup
nnoremap <leader>v <cmd>CHADopen<cr>

" status line setup
lua require('lualine').setup()

" startup setup
lua require('alpha').setup(require'alpha.themes.startify'.opts)

"
" LSP/Rust setup
"
" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

local opts = {
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        runnables = {
            use_telescope = true
        },
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}
require('rust-tools').setup(opts)
EOF

" Code navigation shortcuts
" as found in :help lsp
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>

" Quick-fix
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hover
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
