"======================================="
" General Neovim Settings
"======================================="

" Set up the core behavior of the editor
set number relativenumber       " Show both absolute and relative line numbers
set ignorecase                  " Case-insensitive search
set smartcase                   " Case-sensitive search only if a capital letter is used
set incsearch                   " Highlight matches as you type
set hlsearch                    " Highlight all search results
set mouse=a                     " Enable mouse support in all modes
set clipboard=unnamedplus       " Use the system clipboard
set wildmode=longest,list       " Bash-like tab completion for commands
set ttyfast                     " Speed up terminal scrolling

" Set up indentation and tabs
set tabstop=4                   " Number of columns for a tab character
set shiftwidth=4                " Number of spaces for indenting
set softtabstop=4               " Spaces for backspace and tab keys
set expandtab                   " Convert tabs to spaces
set autoindent                  " Copy indent from the previous line

" Set up UI and display
set nofoldenable                " Disable code folding by default
set signcolumn=yes              " Always show the signcolumn for diagnostics
set updatetime=300              " Shorter delay for diagnostic updates
set termguicolors               " Enable true colors for better syntax highlighting
syntax on                       " Enable syntax highlighting
filetype plugin indent on       " Enable file type-specific plugins and indenting

" Disable swap and backup files
set noswapfile
set nobackup
set nowritebackup

"======================================="
" Plugin Management (vim-plug)
"======================================="

call plug#begin()
  " Core Plugins
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'nvim-telescope/telescope.nvim', {'tag': '0.1.x'}
  Plug 'nvim-lua/plenary.nvim' " A dependency for Telescope
  Plug 'folke/tokyonight.nvim', {'tag': 'v2.2.0'}
  Plug 'vim-airline/vim-airline'
  Plug 'ntpeters/vim-better-whitespace'

  " Language-Specific Plugins
  Plug 'hashivim/vim-terraform'

  " Utility Plugins
  Plug 'jamessan/vim-gnupg'
  Plug 'wellle/context.vim'

  " Claude Code Plugin (Lua-based)
  Plug 'greggh/claude-code.nvim'
call plug#end()

"======================================="
" Plugin Configuration
"======================================="

" Color Scheme
colorscheme tokyonight-night

" COC Configuration
" Basic mappings for diagnostics, navigation, and code actions
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>rn <Plug>(coc-rename)

" Format selected text and entire file
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
command! -nargs=0 Format :call CocActionAsync('format')

" Symbol navigation and renaming
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use K to show documentation
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" Use <C-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Telescope Configuration and Mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"======================================="
" Autocmds
"======================================="

augroup SpellCheck
  autocmd!
  " Enable spell check for specific file types
  autocmd FileType markdown,text setlocal spell spelllang=en
augroup END

augroup CocAutoCommands
  autocmd!
  " Setup formatexpr for specific filetypes
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " Auto-highlight symbols on cursor hold
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

"======================================="
" Lua Plugin Configuration
"======================================="

lua << EOF
require('claude-code').setup()
EOF
