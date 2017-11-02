" Vundle
" let mapleader = " "
set encoding=utf-8
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"Plugin 'terryma/vim-multiple-cursors'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'edkolev/tmuxline.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'easymotion/vim-easymotion'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'junegunn/vim-easy-align'
Plugin 'elzr/vim-json'
Plugin 'posva/vim-vue'
Plugin 'petRUShka/vim-sage'
Plugin 'digitaltoad/vim-pug'
Plugin 'scrooloose/syntastic'
Plugin 'mtscout6/syntastic-local-eslint.vim'
Plugin 'bkad/CamelCaseMotion'
" cia, caa: change argument
Plugin 'sasdf/argtextobj.vim'
" cii cai: change same indent block
Plugin 'michaeljsmith/vim-indent-object'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" CamelCaseMotion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
omap <silent> ic <Plug>CamelCaseMotion_ib
xmap <silent> ic <Plug>CamelCaseMotion_ib
omap <silent> ac <Plug>CamelCaseMotion_iw
xmap <silent> ac <Plug>CamelCaseMotion_iw

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
"let g:syntastic_javascript_checkers = ['standard']
" let g:syntastic_javascript_standard_generic = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint'

" vim-vue
autocmd FileType vue syntax sync fromstart
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction

" airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = ''
let g:airline_left_sep = ''
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
let g:airline_right_sep = ''
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'

let g:airline_theme = 'wombat'


" Tmux line
let g:tmuxline_separators = {
            \ 'left' : '',
            \ 'left_alt': '|',
            \ 'right' : '',
            \ 'right_alt' : '|',
            \ 'space' : ' '}

" NerdTree
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
map <C-n> :NERDTreeToggle<CR>

" EasyMotion
nmap / <Plug>(easymotion-sn)

" Snip & Ycm
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_global_ycm_extra_conf = "~/local/vimfiles/.ycm_extra_conf.py"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-tab>"
" let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_show_diagnostics_ui = 0
" Jumping
noremap <leader>d :YcmCompleter GoToDeclaration<CR>
noremap <leader>D :YcmCompleter GoToDefinition<CR>
noremap <leader>gt :YcmCompleter GoTo<CR>

" Commenter
let g:NERDSpaceDelims = 1

" CtrlP ignore 
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>a <Plug>(EasyAlign)

" General
syntax on
set wildmenu
set foldenable
set mouse=a
set hidden
set number
set relativenumber
set timeoutlen=500
set showcmd
filetype plugin on

" Theme
set t_Co=256
colorscheme monokai

" Tab
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set ai
filetype indent on

" Search
"set showmatch
set incsearch
set hlsearch

" Maps
" Jump between error
fun! ToggleErrors()
  let old_last_winnr = winnr('$')
  silent lclose
  if old_last_winnr == winnr('$')
    " Nothing was closed, open syntastic error location panel
    silent Errors
    if old_last_winnr != winnr('$')
      silent lopen
    endif
  endif
endfunction

fun! ToggleDoc()
  let old_last_winnr = winnr('$')
  silent pclose
  if old_last_winnr == winnr('$')
    " Nothing was closed, open syntastic error location panel
    silent YcmCompleter GetDoc
  endif
  return ""
endfunction

noremap <C-j> :call ToggleErrors()<CR>
inoremap <C-j> <Esc>:call ToggleErrors()<CR>
autocmd FileType qf nmap <buffer> <cr> <cr>:lclose<cr>
noremap <C-k> :call ToggleDoc()<CR>
inoremap <C-k> <C-R>=ToggleDoc()<CR>

" Switch Buffer
fun! PreserveBufferState()
  let b:backupCursorPos = getpos(".")
  let b:backupBufferMode = mode()
endfun
fun! RestoreBufferState()
  " stopinsert
  " if exists('b:backupBufferMode')
    " if b:backupBufferMode == mode()
    " elseif b:backupBufferMode == 'n'
      " stopinsert
    " elseif b:backupBufferMode == 'i'
      " startinsert
    " elseif b:backupBufferMode == 'R'
      " startreplace
    " elseif b:backupBufferMode == 'Rv'
      " startgreplace
    " endif
  " endif
  if exists('b:backupCursorPos')
    let l:backupCursorPos = b:backupCursorPos
    " echom mode()
    if b:backupBufferMode == 'n' && mode() != 'n'
      let l:backupCursorPos[2] += 1
    endif
    call setpos(".", l:backupCursorPos)
  endif
endfun
autocmd BufLeave * call PreserveBufferState()
autocmd BufEnter * call RestoreBufferState()
fun! SwitchBuffer(cmd)
  if &buftype ==# ''
    silent exec a:cmd
    while &buftype !=# ''
      silent exec a:cmd
    endwhile
  endif
  return ""
endfun
noremap <C-h> :call SwitchBuffer('bprevious')<CR>
inoremap <C-h> <C-R>=SwitchBuffer('bprevious')<CR>
noremap <C-l> :call SwitchBuffer('bnext')<CR>
inoremap <C-l> <C-R>=SwitchBuffer('bnext')<CR>

" Clear Search
noremap <leader>n :let @/="noooooooooooooooooooooooop"<CR>

" Toggle paste
noremap <leader>p :silent set paste!<CR>

" Insert Empty Line
noremap <CR> o<Esc>k

" Swap Line
" nnoremap _ ddp
" nnoremap - ddkP

" JK to Esc
inoremap jk <Esc>
inoremap kj <Esc>

" Wrapped movement
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" " Hard Mode :)
" " Disable hl, use webft0$a instead
noremap h <Nop>
noremap l <Nop>

" Disable arrow key, use hjkl instean
inoremap <Up>    <Nop>
inoremap <Esc>[A <Nop>
inoremap <Esc>OA <Nop>
inoremap <Down>  <Nop>
inoremap <Esc>[B <Nop>
inoremap <Esc>OB <Nop>
inoremap <Right> <Nop>
inoremap <Esc>[C <Nop>
inoremap <Esc>OC <Nop>
inoremap <Left>  <Nop>
inoremap <Esc>[D <Nop>
inoremap <Esc>OD <Nop>
inoremap <PageUp> <Nop>
inoremap <PageDown> <Nop>
noremap <Up>    <Nop>
noremap <Esc>[A <Nop>
noremap <Esc>OA <Nop>
noremap <Down>  <Nop>
noremap <Esc>[B <Nop>
noremap <Esc>OB <Nop>
noremap <Right> <Nop>
noremap <Esc>[C <Nop>
noremap <Esc>OC <Nop>
noremap <Left>  <Nop>
noremap <Esc>[D <Nop>
noremap <Esc>OD <Nop>
noremap <PageUp> <Nop>
noremap <PageDown> <Nop>

" Disable ctrl-T indent
inoremap <C-t> <Nop>

" Disable ex mode
noremap Q <Nop>

" Dvorak?
noremap S :echo "Do you mean :? (Shift-Z in Dvorak)"

" Override q and wq to buffer operation
cnoreabbrev q echo "Disabled dangerous operation"
cnoreabbrev wq echo "Disabled dangerous operation"
cnoreabbrev wqa echo "Disabled dangerous operation"
