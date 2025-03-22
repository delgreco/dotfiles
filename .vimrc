" kinda works but not immediately, only after switching vim panes
" autocmd BufEnter * wincmd =
" works after every keypress in vim, but is this too expensive?
" so far, seems not.  Cursor navigation does not seemed slowed.
autocmd CursorMoved * wincmd =

" enable bash aliases within vim
let $BASH_ENV = "~/.bash_aliases"

colorscheme default
" turn on syntax highlighting
syntax on
filetype on
au BufNewFile,BufRead *.t set filetype=perl
" support Perl subroutine signatures in syntax highlighting
let perl_sub_signatures = 1
" making this consistent helps syntax highlighting consistency
set background=light
" increase redrawtime from default 2 seconds
" to improve syntax highlighting support
set redrawtime=10000

"" ensure Delete key works as backspace
set bs=2

" set <TAB> to 4 spaces 
set tabstop=4
" use appropriate number of spaces (above) to insert a <Tab>
set expandtab
" auto-indent 4 spaces
set shiftwidth=4
" round indent to a multiple of 'shiftwidth' (above), applies to > and <
set shiftround
" specify <F10> as key sequence for toggling 'paste' mode
set pastetoggle=<F10>
" copy the indent from current line when starting new line
set autoindent

"" faster scrolling
" capital J will scroll up 3 lines
nmap <silent> J :set scroll=3<cr><c-d>
" capital K will scroll down 3 lines
nmap <silent> K :set scroll=3<cr><c-u>
" paste below current line with a capital P
nmap <silent> P :pu<cr>

" " visual mode mappings (vmap)
" faster visual highlighting
vmap J 2j
vmap K 2k
" replace $template with $t
vmap T :s/\$template/\$t/<cr>

" remap ; to : for easier commands (no SHIFT for last line mode)
nnoremap ; :

" map common commands to be less case sensitive
" for when caps lock is on or the SHIFT key is depressed
command! Wq wq
command! WQ wq
command! WQA wqa
command! W w
command! Q q
command! S Sex

" always display status line
set laststatus=2
" get current user@host
let hostname=system('echo -n $LOGNAME@$(/bin/hostname -s)')
" set the status line to [filename] [doc%] [line:col] [user@host]
"set statusline+=%f\ %P\ %l:%c\ %{hostname}
set statusline=%f\ %P\ %l:%c\ %{hostname}
hi StatusLine ctermbg=white ctermfg=237
hi StatusLineNC ctermbg=white ctermfg=237
" show byte order mark in statusline
set statusline+=\ %{&bomb?'BOM':''}

"  force vim to syntax highlight more aggressively
"  to keep it working.  Could cause slowness.
"  https://stackoverflow.com/questions/3607516/vim-folding-messes-up-syntax-highlighting
"syn sync fromstart
autocmd BufEnter * :syntax sync fromstart

" file browser (netrw) style
let g:netrw_liststyle = 3
" remove banner atop netrw
let g:netrw_banner = 0

" A Damian Conway bit...
" This rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>    
" OR ELSE just highlight the match in red...
function! HLNext (blinktime)
    highlight WhiteOnRed ctermfg=white ctermbg=red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" <F1> write all buffers and execute ixkt
" first, map to <nop> remove the existing mapping which to Help
" changed from nmap to map to see if it improves things
map <F1> <nop>
map <F1> :wa <bar> :! ixkt<CR>
imap <F1> <nop>
imap <F1> <c-o>:wa <bar> :! ixkt<CR>

" <F2> (80) or <F3> (443) open weblogs for current environment in split screen
map <F2> :sp ../error_log<CR> <S-G>
map <F3> :sp ../ssl_error_log<CR> <S-G>
" reload current file and go to bottom
map <F4> :e<CR> <S-G>
" diff current file
map <F5> :SignifyDiff<CR>
" source ~/.vimrc
map <F6> :source ~/.vimrc<CR>
" email the current register
nnoremap <silent> <F7> :silent split clipboard.txt<bar>silent put<bar>1delete _<bar>:w<bar>:exec 'call system("cat clipboard.txt \| mail $USER\@unh.edu")'<bar>:q<bar>:call delete('clipboard.txt')<cr>

" run 'drush cr'
map <F8> <nop>
map <F8> :! drush cr<CR>

" highlight current line during INSERT mode
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline

" insert mode: beam cursor |
" normal mode: block cursor █
" support cursor shape changes within and without tmux
if exists('&guicursor')
    " ironically, could not get guicursor working
    " but the below works in vim 9+
    if exists('$TMUX')
        let &t_SI = "\e[6 q"
        let &t_EI = "\e[2 q"
        " set guicursor=n-v-c:block-Cursor/lCursor
        " set guicursor+=i:ver25-Cursor/lCursor
        " set guicursor+=r:hor20-Cursor/lCursor
    else
        let &t_SI = "\e[6 q"
        let &t_EI = "\e[2 q"
        " set guicursor=n-v-c:block-Cursor/lCursor
        " set guicursor+=i:ver25-Cursor/lCursor
        " set guicursor+=r:hor20-Cursor/lCursor
    endif
else
    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
endif



" templates
" *.pl
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.pl 0r ~/.vim/templates/skeleton.pl
  augroup END
endif
" *.pm
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.pm 0r ~/.vim/templates/skeleton.pm
  augroup END
endif


" set some registers
let @d = "IX::Debug::log(\"\");"
let @n = "<input type=\"hidden\" name=\"IX_noforge_id\" value=\"<TMPL_VAR IX_NOFORGE_ID>\">"

" " automatic plugin installation
if empty(glob('~/.vim/autoload/plug.vim'))
   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
         \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/vim-plug')

set signcolumn=yes
" enable marks in the sign column
Plug 'kshenoy/vim-signature'
"" version control in the gutter (sign column)
"" requires vim > 7.4.1967
Plug 'mhinz/vim-signify'
let g:signify_vcs_list = ['svn']
let g:signify_sign_show_count = 1
let g:signify_line_highlight = 0
let g:signify_sign_change = 'M'
let g:signify_realtime = 1
"nmap <silent> <Leader>sj <plug>(signify-next-hunk)
"nmap <silent> <Leader>sk <plug>(signify-prev-hunk)

" enable multi-line commenting
Plug 'tpope/vim-commentary'

" get smarter - but requires vim compiled with Python 3
if has('python3')
    Plug 'madox2/vim-ai'
endif
let g:vim_ai_token_file_path = '~/.config/openai.token'

"" vim-easymotion - quick jump to line numbers or letter combos

call plug#end()

" fold on indents
set foldmethod=indent
" blue text on grey folds
hi Folded ctermbg=237
hi Folded ctermfg=033

" visual mode, soft grey highlight
hi Visual ctermbg=235

" sign column
"" requires vim > 7.4.2201
hi SignColumn guibg=blue ctermbg=233
hi SignatureMarkText guifg=black ctermfg=darkgrey ctermbg=233
hi DiffAdd           cterm=bold ctermbg=233 ctermfg=40
hi DiffDelete        cterm=bold ctermbg=233 ctermfg=40
hi DiffChange        cterm=bold ctermbg=233 ctermfg=40

highlight link SignifyLineChange DiffText
hi DiffText        cterm=bold ctermbg=233 ctermfg=grey
" load user-specific .vimrc if present
let $file=expand("~/.vimrc.$USER")
if filereadable( $file )
    source $file
endif

