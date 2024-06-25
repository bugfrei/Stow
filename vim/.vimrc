set guifont=Menlo-Regular:h18
" /Users/carstenschlegel
" SETTING FÜR VIM

" Whitespace TAB mit >~~~ anzeigen
setlocal list
set listchars=tab:>~

" Wörterbuch definieren
set dictionary+=/Users/carstenschlegel/.vim/dict/test
set complete+=k

" Runtime-Pfad hinzufügen
set runtimepath+=/Users/carstenschlegel/.vim

" Sprache einstellen
set spelllang=de

" Zeilennummer und relative Zeilennummern
set nu
set rnu

" Welches Terminal
set shell=pwsh

" Kein Zeilenumbruch
set nowrap

" Zeilenumbruch und Backspace
set backspace=indent,eol,start
set whichwrap=<,>,h,l,[,]

" Speichern der aktuellen Suchen, Puffer usw.
set viminfo=%,'50,\"100,:100,n~\\.viminfo

" Standard-Tabstopgröße und andere Tab-Einstellungen
set tabstop=2
set shiftwidth=2
set expandtab

" Automatisches einrücken zur vorherigen Zeile
set autoindent

" Zeile des Cursor wird markiert
set cursorline

" Cursor-Zeile bei INSERT deaktivieren
autocmd InsertEnter,InsertLeave * set cul!
" Position wird in der Statuszeile angezeigt
set ruler

" Alle gefundenen Treffer werden markiert (entfernen mit :noh)
set hlsearch

" mein eigenes Color-Schema
" () sind sichtbar auch wenn der Cursor darauf ist (passende Klammer markieren)
" EINFÜGEN, VISUELL usw. ist sichtbar
" Whitespaces werden auch angezeigt und sind lesbar auch wenn der Cursor darauf ist
colorscheme koehler 

" Suffixes die Vim versucht zu öffnen wenn kein Suffix angegeben wurde
set suffixesadd+=.txt
set suffixesadd+=.cs
set suffixesadd+=.json
set suffixesadd+=.xml
set suffixesadd+=.xaml
set suffixesadd+=.html
set suffixesadd+=.css
set suffixesadd+=.py
set suffixesadd+=.psm1

" Pfade angegeben, in denen nach Dateien mit gf und find gesucht wird
"set path+=C:\Users\Admin\OneDrive\Dokumente\WindowsPowerShell\Modules\Path

" ------------------------------------------------------------------------------------------------------------
"                                                REMAPS
" ------------------------------------------------------------------------------------------------------------
let mapleader="ü"

" ########## Go TOP und Go Bottom                                                                   ########## 
noremap gt gg
noremap gb G

" ########## <Leader>p/P : Vorheriges kopiertes/gelöschtes einfügen                                 ########## 
map <leader>p "0p
map <leader>P "0P

" ########## Strg+. wiederholt den letzten Ex-Befehl                                                ##########
map <C-.> @:
" ########## Aktuelle Zeile oder markierten Bereich duplizieren (ohne Register!)                    ##########
map <C-P> :t.<CR>

" ########## Bewegungen: ß 1. Zeichen links, ´ ende der Zeile, ü 1. Zeile, ä letzte Zeile           ##########
map ß 0^
map ´ $
map ä <C-D>
map ö <C-U>

" ########## Strg+Space  : Am Ende der Zeile EINFÜGEN mit einem Space                               ##########
map <S-Space> A 

" ########## <Leader>w   : Nur speichern wenn sich was geändert hat                                 ##########
noremap <Leader>w :up<cr>

" ########## _           : ` ersetzen (Springe zur Cursorposition der Marke)                        ##########
map _ `

" ------------------------------------------------------------------------------------------------------------
"                                            CODING REMAPS
" ------------------------------------------------------------------------------------------------------------
" ########## <Leader>i  : Innerhalb {} einer Klasse nach dem Klassennamen : für Interfaces,         ##########
" ##########              Vererbung usw. einfügen                                                   ##########
noremap <leader>i kkA : 

" ########## F5         : Pythonskript ausführen                                                    ##########
map <F5> :w<CR>:!py %<CR>

" ########## Strg+7     : Redo (für Visual Studio, da dort Strg+R anders belegt)                    ##########
map <C-7> :redo<CR>

" ########## Shift-Ö für {}-Umschluss bei Zeilenmarkierungen (V), nur ö bei Zeichenmarkierung (v)   ##########
"vmap Ö "gdi{<CR>}<CR><ESC>kmg=k"gpV'g=
"vmap ö "gdi{ }<ESC>"gPa <ESC>
" ########## Strg+F11   : Nach einfügen neuer Klasse diese public machen                            ##########
" ##########              (<Leader>i um danach Vererbung/Interfaces einzutragen)                    ##########
map <C-F11> gg8j^^ipublic<Space><Esc>jo

" ########## An Variablenname am Ende des Feldes ein _ voranstellen                                 ##########
map <Leader>- bi_<Esc>A
" ------------------------------------------------------------------------------------------------------------
"                                            DEAKTIVIERTE MAPS
" ------------------------------------------------------------------------------------------------------------
" ########## Strg+C und Strg+V für Kopieren/Einfügen                                                ##########
" vnoremap <C-c> "+y
" map <C-v> "+p

" ########## FÜR UBUNTU VIM!                                                                        ##########
" let &t_SI = "\<esc>[5 q"
" let &t_SR = "\<esc>[3 q"
" let &t_EI = "\<esc>[2 q"

" ########## Cursorbewegung umschalten (von jk normale Zeilen zu jk anzeigezeilen);nur bei set wrap ##########
" nnoremap k gk
" nnoremap j gj
" nnoremap gk k
" nnoremap gj j

" ########## Cursortasten unbrauchbar machen (zum erlernen der hjkl-Navigation)                     ##########
" noremap <Up> <Nop>
" noremap <Down> <Nop>
" noremap <Left> <Nop>
" noremap <Right> <Nop>

" ########## Entfernentaste als Esc-Taste nutzen                                                    ##########
" nnoremap <Del> <Esc>
" vnoremap <Del> <Esc>gV
" onoremap <Del> <Esc>
" cnoremap <Del> <C-C><Esc>
" inoremap <Del> <Esc>`^
" tnoremap <Del> <C-\><C-n>

" --- NICHT FUNKTIONIERENDE MAPS ---

" vnoremap ö exe "'< normal O{\<esc>" | exe "'> normal o}\<esc>" | exe "'<,'> normal >>"

nnoremap gy 0v$h"+y




" --------------OOOO---------
" Windows like Strg+Z   für UNDO
" map <C-z> u
" Windows like Strg+Y   für REDO
map <C-y> <C-r>
" Alternative: zu       für UNDO
" map zu u
" Alternative: zU       für REDO
" map zU <C-r>
"        oder: zr       für REDO
" map zr <C-r>

" Return für neue Zeile einfügen & insertmodus
noremap <CR> o


map üüf i<C-V>U1f449<Esc>
map üüe i<C-V>U1f3f4<Esc>
map üüd i<C-V>U1f1e9<Esc>
map üüb i<C-V>U26a1<Esc>

" ########## _           : ciq, viq, yiq, diq nutzbar machen (aus VSC)                              ##########
" Verlangsamen d, c, v, und y Befehl!!!
nnoremap ciq ci"
nnoremap viq vi"
nnoremap yiq yi"
nnoremap diq di"

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

cd /Users/carstenschlegel/Notizen
