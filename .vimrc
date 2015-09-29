" color that shit
syntax on
set t_Co=256
colorscheme solarized
set background=light

" Init pathogen
execute pathogen#infect()

" disable arrow keys
"no <down> <Nop>
"no <up> <Nop>
"no <left> <Nop>
"no <right> <Nop>
"
"ino <down> <Nop>
"ino <up> <Nop>
"ino <left> <Nop>
"ino <right> <Nop>

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
filetype plugin on
filetype on

" Switch between splits
map <silent> <S-Right> <c-w>l
map <silent> <S-Left> <c-w>h
map <silent> <S-Up> <c-w>k
map <silent> <S-Down> <c-w>j

" jump in lines
"map <C-e> <esc>$a
"imap <C-a> <esc>$^

" NerdTree Settings
map <F2> :NERDTreeToggle<CR>
autocmd BufEnter * lcd %:p:h

" enabling airline
set laststatus=2
" show tabline
let g:airline#extensions#tabline#enabled = 1
" Show git info in airline
let g:airline#extensions#hunks#enabled=0
" set airline theme
" let AirlineTheme base16


" Add Tagbar keybinding
nnoremap <F3> :TagbarToggle<CR>
let g:tagbar_usearrows = 1

" Toggle gundo
nnoremap <F1> :GundoToggle<CR>
" Configure gundo size
let g:gundo_width = 30
let g:gundo_preview_height = 28
let g:gundo_help = 0


" keymapping to resize splits
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
endif

" Configure Ailine
let g:airline_theme = 'solarized'
set guifont=Source\ Code\ Pro\ for\ Powerline:h12
let g:airline_powerline_fonts = 1

" configure syntastic to use python3
let g:syntastic_python_python_exec = '/usr/bin/python3'

" Toggle Tastlist
map <F5> <Plug>TaskList
