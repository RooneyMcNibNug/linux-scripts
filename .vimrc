### My simple vim configuration file
set number
set wrap
set linebreak
set noerrorbells
set visualbell
set shiftwidth=4
set tabstop=4
set expandtab
set modeline
set autoindent
set showcmd
set ruler

syntax on

filetype indent on
filetype plugin on
map \p i(<Esc>ea)<Esc>
map \[ i[<Esc>ea]<Esc>
map \" i"<Esc>ea"<Esc>
map \' i'<Esc>ea'<Esc>
map \{ i{<Esc>ea}<Esc>
map \m <Esc>:%! tr '\r' '\n'<Return>

if has ("gui_running")
	set background=dark
	"
	" set transparency=2
    set guioptions-=T
    set t_Co=256
else
	set background=dark
    set t_Co=256
endif
