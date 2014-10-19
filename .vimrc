" color that shit
syntax on
set t_Co=256
colorscheme solarized
set background=dark

" Init pathogen
execute pathogen#infect()

" disable arrow keys
no <down> <Nop>
no <up> <Nop>
no <left> <Nop>
no <right> <Nop>

ino <down> <Nop>
ino <up> <Nop>
ino <left> <Nop>
ino <right> <Nop>


" Add line numbers
set number
set cursorline
" Setting a vertical ruler at char x
" set colorcolumn=85

" set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=3
set shiftwidth=3
set softtabstop=3
set expandtab

" Show trailing spaces and highlight hard tabs
set list listchars=tab:»·,trail:·

" Strip trailing whitespaces on each save
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()


" configure search
set hlsearch
nnoremap <CR> :nohlsearch<CR><CR>
noremap <F4> :set hlsearch! hlsearch?<CR>

" filetype plugin indent on
" filetype plugin on

" Switch between splits
map <silent> <S-Right> <c-w>l
map <silent> <S-Left> <c-w>h
map <silent> <S-Up> <c-w>k
map <silent> <S-Down> <c-w>j

" jump in lines
map <C-e> <esc>$a
imap <C-a> <esc>$i

" NerdTree Settings
map <F2> :NERDTreeToggle<CR>

" enabling airline
set laststatus=2

" Show git info in airline
let g:airline#extensions#hunks#enabled=0

" Add Tagbar keybinding
let g:tagbar_usearrows = 1
nnoremap <F3> :TagbarToggle<CR>
