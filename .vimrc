set nocompatible
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround  
set smarttab    
set cindent  
set copyindent  
set number      " show line numbers
set relativenumber
set ic
set smartcase
set nowrap
set ruler       " show line number/curosr position on bottom right

set incsearch   " start searching as you type
set hlsearch    " highlight search matches automatically

set whichwrap+=<,>,h,l,[,]

set noswapfile
set hidden

set cino+=(0    " indent function args to (

set backspace=indent,eol,start   " get backspace working like most programs

syntax on
filetype plugin indent on

let mapleader = ' '

""""""""" color/appearance configs """"""""""
"set transparency=10
colorscheme zellner

" highlight green text against blue 
:hi Visual term=reverse cterm=reverse gui=bold guifg=#206040 guibg=LightBlue   

" vim fold highlight background for foldsearch
:highlight Folded guibg=grey30 guifg=blue

" completion list shows up in statusline
set wildmenu
set wildmode=longest:full,full

"set showmatch  " Matching brackets
set visualbell  " mutes sound on macvim

set noequalalways " prevent resizing of windows when closing a split

""""""" vundle """"""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'https://github.com/kien/ctrlp.vim.git'
Plugin 'https://github.com/rgarver/Kwbd.vim.git'
Plugin 'https://github.com/vim-scripts/MultipleSearch.git'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/vim-airline/vim-airline.git'
Plugin 'https://github.com/vim-scripts/vim-auto-save.git'
Plugin 'https://github.com/altercation/vim-colors-solarized.git'
Plugin 'https://github.com/junegunn/vim-easy-align.git'
Plugin 'https://github.com/xolox/vim-easytags.git'
Plugin 'https://github.com/airblade/vim-gitgutter.git'
Plugin 'https://github.com/xolox/vim-session.git'
Plugin 'https://github.com/xolox/vim-misc.git'
Plugin 'https://github.com/vim-scripts/AnsiEsc.vim.git'
Plugin 'https://github.com/vim-scripts/Mark--Karkat'
Plugin 'sheerun/vim-polyglot'
Plugin 'majutsushi/tagbar'
Plugin 'taglist.vim'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-capslock'    " enable with <C-G>c in insert mode

Plugin 'https://github.com/ramele/agrep.git'
"Plugin 'https://github.com/maralla/validator.vim.git'
Plugin 'https://github.com/skywind3000/asyncrun.vim.git'
Plugin 'https://github.com/tpope/vim-unimpaired.git'

Plugin 'https://github.com/tpope/vim-repeat.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
""""""" plugins """"""""""
execute pathogen#infect()

"source ~/.vim/plugin/comments.vim
"source ~/.vim/plugin/foldsearch.vim
:let g:foldsearch_disable_mappings = 1
"source ~/.vim/winpos.vim


:let g:session_autosave = 'no'
:let g:session_autoload = 'no'
"function !SaveAndCloseSession()
    "SaveSession!
    "CloseSession
"endfunction
"au VimLeavePre * call SaveAndCloseSession()

"let g:validator_cpp_checkers = ['clang-tidy']
"let g:validator_clang_tidy_binary = '/usr/bin/clang-tidy-3.5'

""""""""" cscope quickfix """""""""

" use :cn and :cp to move between tags when working with cscope result list
set cscopequickfix=s-,c-,d-,i-,t-,e-



""""""""" default directory """"""""""
":cd ~/dev/


"""""""""""" youcompleteme """""""""
"let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
"let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py"
"let g:ycm_register_as_syntastic_checker = 0


"""""""""""" autosave """"""""""
let g:auto_save = 1  " enable AutoSave on Vim startup

"AutoSave relies on CursorHold event and sets the updatetime option to 200 so that modifications are saved almost instantly.
"But sometimes changing the updatetime option may affect other plugins and break things.
"You can prevent AutoSave from changing the updatetime with g:auto_save_no_updatetime option:
let g:auto_save_no_updatetime = 25  " do not change the 'updatetime' option
let g:auto_save_in_insert_mode = 0  " NOTE: manual code change to plugin to not save when leaving insert

""""""""""  easytags """""""""""""""

" old regexpengine to avoid slowdown
set regexpengine=1

" faster tag highlighting
let g:easytags_async = 1
let g:easytags_auto_highlight = 1
let g:easytags_syntax_keyword = 'always'
let g:easytags_python_enabled = 1
let g:easytags_updatetime_min = 60000

""""" linux ctags configuration """"""
"let g:easytags_file = '/home/phahn/ctags'
let g:easytags_opts = ["--options=/home/phahn/ctags.cnf"]
"let g:easytags_opts = ["-L /home/phahn/ctags.files"]
"let g:easytags_include_members = 0
let g:easytags_cmd = '/usr/local/bin/ctags'
""""" linux ctags configuration """"""

""""""""" airline """"""""""""

" show airline every file
set laststatus=2
let g:airline#extensions#syntastic#enabled = 0


""""""""" ctrlp configuration """"""""""
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 100
let g:ctrlp_root_markers = ['.ctrlp']
let g:ctrlp_clear_cache_on_exit = 0

nnoremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <C-p> :CtrlPTag<CR>
""""""""" ccommandT configuration """"""""""
set wildignorecase
set wildignore+=*.o,*.obj,*.class,*.compact,*.2d,*.json,*.png,*.plo,*.po,*.pdf,*.html,*.xml,*.jpg,*.jpeg,*.jar,*.graffle,*.zip,*.so,*.fw,*.3gp,*.mp4
"set wildignore+=20140422_new_src_SD_boot/**,20140603_fw_May_29_2014/**,image_quality/**
nnoremap <silent> <leader>o ::CommandT ~/dev/<CR>
let g:CommandTMaxFiles = 500000
let g:CommandTInputDebounce = 700
let g:CommandTMaxCachedDirectories = 10
let g:CommandTHighlightColor="Visual"

""""""""" NERDTree configs """"""""""""""""
noremap <silent> <leader>N :NERDTreeFind<CR>
noremap <silent> <leader>n :NERDTreeToggle<CR>
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = "RO"
let g:NERDTreeWinPos = "right"




"""""""" autoread python """""""""""""
fun! AutoreadShell()
    if v:servername == ''
        echoerr 'v:servername is empty; we need a servername for this.'
    endif

    let l:oldshell = &shell " For maximum compatibility (fish/csh users)
    let &shell = '/bin/zsh'
    let l:cmd = 'vim --servername ' . v:servername . ' --remote-send ":checktime<CR>" --remote-send ":redraw<CR>"'
    call system('while :; do sleep 1; ' . l:cmd . '; done &') " Note the & at the end
    let &shell = l:oldshell
endfun

fun! StopAutoread()
  call system('killall -9 zsh')
endfun



""""""""" clear inactive buffer http://stackoverflow.com/questions/1534835/how-do-i-close-all-buffers-that-arent-shown-in-a-window-in-vim """""""""""""""

function! CloseHiddenBuffers()
    " Tableau pour memoriser la visibilite des buffers                                                                                      
    let visible = {}
    " Pour chaque onglet...
    for t in range(1, tabpagenr('$'))
        " Et pour chacune de ses fenetres...
        for b in tabpagebuflist(t)
            " On indique que le buffer est visible.
            let visible[b] = 1
        endfor
    endfor
    " Pour chaque numero de buffer possible...
    for b in range(1, bufnr('$'))
        " Si b est un numero de buffer valide et qu'il n'est pas visible, on le
        " supprime.
        if bufexists(b) && !has_key(visible, b)
            " On ferme donc tous les buffers qui ne valent pas 1 dans le tableau et qui
            " sont pourtant charges en memoire.
            execute 'bwipeout' b
        endif
    endfor
endfun

""""""""" trim trailing whitespace """"""""""
"autocmd FileType c,cpp,h,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e
:map "c :%s/\s\+$//e<CR>


""""""""" commentline configuration """"""""""
" key-mappings for comment line in normal mode
noremap  <silent> <leader><cr> :call CommentLine()<CR>
noremap  <silent> <s-cr> :call CommentLine()<CR>
" key-mappings for range comment lines in visual <Shift-V> mode
vnoremap <silent> <leader><cr> :call RangeCommentLine()<CR>
vnoremap <silent> <s-cr> :call RangeCommentLine()<CR>
" key-mappings for un-comment line in normal mode
noremap  <silent> <c-n> :call UnCommentLine()<CR>j
" key-mappings for range un-comment lines in visual <Shift-V> mode
vnoremap <silent> <c-n>  :call RangeUnCommentLine()<CR>





""""""""""" Map wq to w, wqq to wq """"""""""""
:map :wq :w
:map :wqq :unmap :wq<cr>:wq<CR>:map :wq :w<CR>


"""""""" quote-key combo macros """"""""""
"open logcat 0 autoread noswap
map "1t :tabnew<cr>:cd ~/temp<CR>:e logcat0.txt<CR>:setlocal autoread<CR>:setlocal noswapfile<CR>


"copy directory/filename to clipboard
:nmap "P :let @+ = expand("%:p")<CR>
:nmap "p :let @+ = expand("%:p:h")<CR>
:nmap "gp :let @+ = expand("%:p:h")<CR>:cd <C-r>+<CR>


"retab convert tab to space and get rid of carriage return or whatever ^M is
map "RM :%norm! $x<CR>:%retab<CR>
map "RR :%retab<CR>

map 'll :set autoread<CR>

map 's1 :mks! ~/.vim/session1.vim<CR>
map 's2 :mks! ~/.vim/session2.vim<CR>
map 's3 :mks! ~/.vim/session3.vim<CR>
map 'l1 :source ~/.vim/session1.vim<CR>
map 'l2 :source ~/.vim/session2.vim<CR>
map 'l3 :source ~/.vim/session3.vim<CR>


map "Q :CloseSession<bar>q<CR>


map "b :tab ball<CR>

nmap '<TAB> 0]}v%j>]}<<
nmap '<S-TAB> 0]}v%j<]}>>

" reverse all lines
map "R :g/^/m0<CR>

map 'as :execute AutoreadShell()<CR>
map 'ax :execute StopAutoread()<CR>

"""""""" FN key remapping """""""""""""
" copy paste in mac terminal
nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>

" reexec last macro
nmap <F2> @@

nmap <F4> :.w !pbcopy<CR><CR>
vmap <F4> :w !pbcopy<CR><CR>

" file reopen /force reopen
nmap <F5> :e<CR>
nmap '<F5> :e!<CR>
nmap <F6> :windo execute ":e!"<CR>:windo execute "normal! Gz."<CR>:redraw!<CR>


"<F7> for word case toggle & <F8> for word capitalization
"Normal mode mappings:
nmap <F7> mzg~iw`z
nmap <F8> mzgUiw`z
"Insert mode mappings:
imap <F7> _<Esc>mza<C-Right><Esc>bg~iw`zi<Del>
imap <F8> _<Esc>mza<C-Right><Esc>bgUiw`zi<Del>


" open finder in folder of current file
map <F10> :! open "%:p:h"<CR>






"""""""""various insert mode movement remaps """"""""""
imap <C-d> <DEL>
imap <M-d> <C-DEL>
imap <C-J> <C-O>j
imap <C-K> <C-O>k
imap <C-H> <Left>
imap <C-L> <Right>
imap <C-BS> <C-W>
imap <C-Del> <C-O>vwx
imap <M-h> <C-Left>
imap <M-l> <C-Right>
imap <M-j> <C-O>j
imap <M-k> <C-O>k
imap <M-o> <C-O>o
imap <M-O> <C-O>O
imap <M-g> <C-O>0
imap <M-;> <C-O>-


"""""""" various other key remaps """"""""""


" '-' to move to end of line
map - $

" shift buffer left and right
map <C-L> zL
map <C-H> zH

" insert line break, spaces, tabs
nnoremap <C-J> i<CR><Esc>h
nnoremap <M-j> i<SPACE><Esc>
"nnoremap <M-J> i<TAB><Esc> doesn't work for linux

" multi color search mark karkat
map <Bslash> :Mark 

" ctrl tab to move around tabs
map <C-Tab> :tabn<CR>
map <C-S-Tab> :tabp<CR>
imap <C-Tab> <C-O>:tabn<CR>
imap <C-S-Tab> <C-O>:tabp<CR>

" ctrl tab alternative 
map <M-S-o> :tabn<CR>
map <M-S-i> :tabp<CR>
"map Q :tabn<cr>
"map <leader>q :tabp<cr>
map W :tabnext<cr>
map Q :tabprev<CR>

map T :tabclose<CR>Q


" backspace in normal mode
nmap <BS> a<BS>



map <C-s> :w<CR>
imap <C-s> <esc>:w<CR>li
 
" increment decrement remap
noremap <C-Z> <C-x> 
noremap <C-z> <C-a> 

" map <c-A> ggVG"+y
 



" equivalent o command on current line
map <m-o> ii<esc>==cl

vmap * "zy/<c-r>z<cr>
vmap # "zy?<c-r>z<cr>
 


" copy paste for parallels but if messes up block edit and other things
"vmap <c-s-c> "+y
"map <c-s-v> i<c-r>+<esc>
"imap <c-s-v> <c-r>+
"
""""""""""""""" Meta key maps """"""""""""""""""


"map <C-S-e> :tabe ~/.wine/drive_c/winepath.txt<CR>v-gf<C-o>:bd<CR>
"map <C-S-e> :tabe ~/temp/winepath.txt<CR>v-gf:bp<bar>bp<bar>sp<bar>bn<bar>bd<CR>
"map <C-S-E> :tabe ~/temp/winepath.txt<CR>v-gf<C-b>winepath<CR>:Kwbd<CR>


map <M-S-l> :bd!<CR>


nmap <M-a> :tabe ~/temp/winepaste.txt<CR>ggdG"+p:w<CR>:bd<CR>
"vmap <C-S-a> <c-c>:tabe ~/temp/winepaste.txt<CR>ggdG"+p:w<CR>:bd<CR>


"  cscope search symbol with meta key
"   's'   symbol: find all references to the token under cursor
"   'g'   global: find global definition(s) of the token under cursor
"   'c'   calls:  find all calls to the function name under cursor
"   't'   text:   find all instances of the text under cursor
"   'e'   egrep:  egrep search for the word under cursor
"   'f'   file:   open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called: find functions that function under cursor calls
"map <M-s> <C-\>s
"map <M-g> <C-\>g
"map <M-c> <C-\>c
"map <M-t> <C-\>t
"map <M-e> <C-\>e
"map <M-f> <C-\>f
"map <M-i> <C-\>i
"map <M-d> <C-\>d

""""""""""" LINUX INSTALL """""""""""""
" Ctags depends on:
"   - installing exuberant ctags
"   - configuration file ~/ctags.cnf for exclusions
"   - ctags-filegen script generating file list
"   - setting up directory 
"      let g:easytags_opts = ["-L $HOME/dev/ctags/ctags.files"]
"   - execute UpdateTags
"
" Cscope depends on:
"   - installing cscope
"   - cscope-gen file for filelist and output symbol
"   - configure .vim/plugin/cscope.vim with full path to cscope-gen output
"map <M-u> :UpdateTags -R $HOME/dev/pancam/hardware<CR>
"map <M-i> :!/home/peterh/dev/ctags-filegen<CR>
"map <M-u> :!$HOME/dev/ctags/ctags-filegen<CR>:UpdateTags -R<CR><:!$HOME/dev/cscope/cscope-gen<CR>:cscope reset<CR>
"

"""""""""" MAc OSX INSTALL """""""""""
" see ~/.ctags for configuration 
" $ cat ~/.ctags
" --c++-kinds=+p
" --fields=+iaS
" --exclude=.git
" --exclude=*AmbaRelease_21-2-evk*
" --exclude=*AmbaRelease_21-2-pure*
" --exclude=*AmbaRelease_21-2uc*
" --exclude=*20140422_new_src_SD_boot*
" --exclude=*20140603_fw_May_29_2014*
" --exclude=*usbx_host_controllers*
" --exclude=*usbx_device_controllers*
let g:asyncrun_open = 10
map <leader>U  :AsyncRun ~/dev/cscope/cscope-gen<CR>
map <leader>u  :ccl<CR>:cscope reset<CR><CR>
"map <leader>u  :ccl<CR>:cscope reset<CR>:UpdateTags -R /home/phahn/dev/mp_vision/modules<CR><CR>
"map <leader>u  :ccl<CR>:cscope reset<CR><CR>

"""""""""""""""" Leader key maps """""""""""""""""""""""

map <leader>l <c-w>l
map <leader>h <c-w>h
map <leader>k <c-w>k
map <leader>j <c-w>j

" unmap combos starting with 'h' to avoid combo wait timeout when switching
" window panes
:let g:gitgutter_map_keys = 0
"unmap <leader>hp
"unmap <leader>hu
"unmap <leader>hs
map <leader>gp :GitGutterPreviewHunk<CR>
map <leader>gr :GitGutterRevertHunk<CR>
map <leader>gs :GitGutterStageHunk<CR>
map <leader>gu :GitGutterUndoHunk<CR>
map [g :GitGutterPrevHunk<CR>
map ]g :GitGutterNextHunk<CR>

map <leader>_ <c-w>g<c-]>
map <leader>- <c-w><c-]><c-w>T
"map <leader>} g<c-]>2<CR>zz
map <leader>+ g<c-]>
map <leader>= g<c-]>1<CR>:sleep 1<CR><CR>
map <leader>] <c-]>zz
map <leader>[ <c-t>zz
map <leader>' <c-w>}:ptjump<CR>
map <leader>; <c-w>v:vertical resize 50<cr>g<c-]>zz<c-w>l
map <leader>L <c-w>h:q<cr>
map <leader>: :only<CR>
map <leader>" :pc<CR>

map <leader>/ :noh<cr>

map <leader>t :TagbarToggle<CR>
map <leader>f :TlistToggle<CR>

map <leader>c :%y+<CR>
vmap <leader>c "+y
map <leader>C :execute CloseHiddenBuffers()<CR>

" map <leader>m :cn<CR>zz   " use ]q and [q from unimpaired
" map <leader>M :cp<CR>zz

" vimrc auto open and write/source
nmap <leader>S :tabe $MYVIMRC<CR>
map <leader>s :source ~/.gvimrc<CR>

" go back with your right hand during navigation
map <leader>O <c-o>


" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

map <leader>a :AsyncRun! ag 

map <leader>r :OpenSession default<CR>

map <leader>w :tabclose<CR>

map <leader>i f,a<CR><ESC>
""""""""""""""" bullshit workarounds """"""""""""""


" macvim hanging on gd
" map gd #

"""""""""""""""""' linux keys """""""""""""""
" vim doesn't do c-q for visual mode
nnoremap <c-q> <c-v>

nmap <c-v> "+P
vmap <c-c> "+y
vmap <c-v> x<esc><c-v>
imap <c-v> <esc><c-v>i
imap <c-s-v> <c-r>+


highlight Ignore guifg=#002b36 guibg=#002b36
match Ignore /\r$/


set pastetoggle=<F2>

au BufNewFile,BufRead *.cu set filetype=cuda
au BufNewFile,BufRead *.cuh set filetype=cuda

set tags=./tags;,tags;
map <leader>e :set tags=./tags;,tags;<CR>

map <CR> <Nop>

" when you see inconsistent highlighting  see
" https://vi.stackexchange.com/questions/27450/syntax-coloring-is-inaccurate-for-html-files-with-css-code-in-it
map <leader>y :syn sync fromstart<CR>
