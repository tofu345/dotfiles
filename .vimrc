set nocompatible
set noswapfile
set hidden
set scrolloff=4

set nowrap
set incsearch
set ignorecase

set noautoindent
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab

set number
set rnu
set signcolumn=yes
set showcmd
set showmode

nnoremap <C-p> <Cmd>GFiles<CR>
nnoremap <Space>l <Cmd>Buffers<CR>
nnoremap <Space>pf <Cmd>Files<CR>
nnoremap <Space>ps <Cmd>Rg<CR>
nnoremap <Space>y "+y
tnoremap <Esc> <C-\><C-n>

" remove all trailing whitespace
execute "set <M-f>=\ef"
nnoremap <silent> <M-f> :%s/\s\+$//e<CR>

" download vim-plug if missing
if empty(glob("~/.vim/autoload/plug.vim"))
    silent! execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * silent! PlugInstall
endif

call plug#begin()

" Plug 'sheerun/vim-polyglot'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-eunuch'

call plug#end()

colorscheme jellybeans

let g:dirvish_mode='sort ,^.*[\/],' " netrw like
let g:dirvish_relative_paths = 0

" transparent background
hi Normal guibg=NONE ctermbg=NONE
hi NonText ctermbg=NONE guibg=NONE
hi LineNr ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
