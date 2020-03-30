" Backup Rules
" as annoying as it is to have vim complain for trying to edit a file that is
" already being edit, it is much better than losing tons of work in an
" edited-but-not-written file
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
