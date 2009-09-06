" mappings

" menus
" <F11> - switch buffer encoding
set  wildmenu
set  wcm=<Tab>
menu Encoding.cp1251     :e ++enc=cp1251<CR>
menu Encoding.koi8-r     :e ++enc=koi8-r<CR>
menu Encoding.cp866      :e ++enc=cp866<CR>
menu Encoding.utf-8      :e ++enc=utf-8<CR>
map  <F11> :emenu Encoding.<Tab>

"<Ctrl-F11> - convert file encoding
set  wildmenu
set  wcm=<Tab>
menu FEnc.cp1251    :set fenc=cp1251<CR>
menu FEnc.koi8-r    :set fenc=koi8-r<CR>
menu FEnc.cp866     :set fenc=cp866<CR>
menu FEnc.utf-8     :set fenc=utf-8<CR>
map  <C-F11> :emenu FEnc.<Tab>

"<Shift-F11> - switch EOL format
set  wildmenu
set  wcm=<Tab>
menu EOL.unix :set fileformat=unix<CR>
menu EOL.dos  :set fileformat=dos<CR>
menu EOL.mac  :set fileformat=mac<CR>
map  <S-F11> :emenu EOL.<Tab>



"nmap <C-n><C-n> :set invnumber <CR>      " show/hide numbers
" undo
nmap <C-z> :undo<CR>
imap <C-z> <Esc> :undo<CR>i
" close current buffer
nmap <S-Esc> :bd<CR>
imap <S-Esc> <Esc> :bd<CR>i

" switch buffers
nmap <C-p> :bp<CR>
nmap <C-n> :bn<CR>
" save buffer
nmap <F2> :w<CR>
" save buffer
imap <F2> <Esc>:w<CR>i
" save all buffers
nmap <S-F2> :wa<CR>
" buffer list
nmap <S-Tab> :BufExplorer<CR>
nmap <S-F4> :BufExplorer<CR>

" quit
imap <F12> <Esc>:qa<CR>
nmap <F12> :qa<CR>
imap <S-F12> <Esc>:q!<CR>
nmap <S-F12> :q!<CR>

" save all & make
imap <F7> <Esc>:wa<CR>:make<CR>
nmap <F7> :wa<CR>:make<CR>

" save all & make clean & make
imap <S-F7> <Esc>:wa<CR>:make<Space>clean<CR>:make<CR>
nmap <S-F7> :wa<CR>:make<Space>clean<CR>:make<CR>

" open error list
imap <F8> <Esc>:copen<CR>
nmap <F8> :copen<CR>
" close error list
imap <S-F8> <Esc>:cclose<CR>i
nmap <S-F8> :cclose<CR>
" next error
imap <C-F8> <Esc>:cnext<CR>i
nmap <C-F8> :cnext<CR>

" TagList plugin
noremap <silent> <F9> :TlistToggle<CR>

" map < & > to indent blocks
vnoremap < <gv
vnoremap > >gv

map <PageUp> <C-U><C-U>
imap <PageUp> <C-O><C-U><C-O><C-U>
nmap <PageDown> <C-D><C-D>
imap <PageDown> <C-O><C-D><C-O><C-D>

"switch between several windows
map <C-j> <C-w><C-w>

"set pastetoggle=<F8>


