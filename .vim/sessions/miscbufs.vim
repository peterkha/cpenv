" ~/.vim/sessions/miscbufs.vim:
" Vim session script.
" Created by session.vim 2.10.1 on 04 September 2015 at 06:08:43.
" Open this file in Vim and run :source % to restore your session.

set guioptions=egmrL
silent! set guifont=Menlo\ Regular:h18
if exists('g:syntax_on') != 1 | syntax on | endif
if exists('g:did_load_filetypes') != 1 | filetype on | endif
if exists('g:did_load_ftplugin') != 1 | filetype plugin on | endif
if exists('g:did_indent_on') != 1 | filetype indent on | endif
if &background != 'dark'
	set background=dark
endif
if !exists('g:colors_name') || g:colors_name != 'solarized' | colorscheme solarized | endif
call setqflist([])
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/dev/mac/pancam/hardware
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +437 neolib/inc/NeoInterface.h
badd +17 neolib/inc/NeoLibInterface.h
badd +1 neocommonproto/NeoMessages.options
badd +1 neocommonproto/NeoMessages.proto
badd +1 neofirmware/Jaunt/Proto/NeoMessages.pb.c
badd +17 neofirmware/Jaunt/Proto/PancamMessages.pb.c
badd +1 neofirmware/Jaunt/Proto/PancamMessages.pb.h
badd +17 neofirmware/Jaunt/Camera/UsbControl.c
badd +706 neofirmware/Jaunt/Camera/StatusManager.c
badd +1 neolib/build_debug/NeoMessages.pb.h
badd +1 neolib/src/NeoConnector.cc
badd +160 neofirmware/Jaunt/Uart/CameraClient.c
badd +331 neofirmware/Jaunt/AppStateMachine.c
badd +279 neofirmware/Jaunt/AppStateMachine.h
badd +961 neofirmware/Jaunt/Platform/PlatformUsb.c
badd +33 neofirmware/Jaunt/Platform/PlatformUsb.h
badd +284 neofirmware/Jaunt/Platform/Platform.c
badd +260 neofirmware/Jaunt/Platform/Platform.h
badd +52 neofirmware/Jaunt/ShellCommands.c
badd +245 neofirmware/Jaunt/CommandProc/CommMessages.c
badd +12 neofirmware/Jaunt/Camera/UsbControl.h
badd +201 neofirmware/Jaunt/Camera/UsbControlFileIO.c
badd +1 20140422_new_src_SD_boot/Detail.txt
badd +98 neofirmware/Jaunt/Utilities/StreamInterface.c
badd +38 neofirmware/Jaunt/Uart/UartInterface.h
badd +22 neofirmware/Jaunt/Uart/UartInterface.c
badd +23 neofirmware/Jaunt/Usb/UsbInterface.c
badd +28 neofirmware/Jaunt/Utilities/StreamInterface.h
badd +52 neofirmware/Jaunt/CommandProc/UsbResponses.h
badd +32 neofirmware/Jaunt/CommandProc/UsbResponses.c
badd +228 neofirmware/Jaunt/CommandProc/CommMessages.h
badd +1 ~/.vimtags
badd +729 neofirmware/AmbaRelease_21-evk/A9/Workshop/A9EVK/src/AmbaSensor_IMX174.c
badd +335 neofirmware/Jaunt/Platform/PlatformNandPROM.c
badd +37 neofirmware/Jaunt/Platform/PlatformNandPROM.h
badd +162 neofirmware/Jaunt/Platform/PlatformRigSerial.c
badd +1 neofirmware/Jaunt/Platform/PlatformRigSerial.h
badd +149 neofirmware/Jaunt/Proto/NeoMessages.pb.h
badd +259 neofirmware/Jaunt/AppStates/HelperApi.c
badd +81 neofirmware/Jaunt/AppStates/AppStateMachinePrivate.h
badd +0 ~/Desktop/FileIO.c
badd +19 neofirmware/Jaunt/Camera/UsbControlFileIO.h
badd +168 neofirmware/AmbaRelease_21-neo/A9/inc/ThreadX/tx_port_SMP.h
badd +0 ~/dev/AmbaRelease_21.2/A9/Workshop/A9EVK/FirmwareUpdater/src/AmbaFirmwareUpdater.c
badd +1 neocommonproto/PancamMessages.proto
badd +149 neolib/build_debug/PancamMessages.pb.h
argglobal
silent! argdel *
argadd neolib/src/NeoConnector.cc
set stal=2
edit neolib/inc/NeoInterface.h
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 709 - ((71 * winheight(0) + 36) / 72)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
709
normal! 04|
tabedit neocommonproto/NeoMessages.proto
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 58 + 32) / 65)
exe 'vert 1resize ' . ((&columns * 95 + 101) / 203)
exe '2resize ' . ((&lines * 4 + 32) / 65)
exe 'vert 2resize ' . ((&columns * 95 + 101) / 203)
exe 'vert 3resize ' . ((&columns * 107 + 101) / 203)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 177 - ((57 * winheight(0) + 29) / 58)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
177
normal! 0
wincmd w
argglobal
edit neocommonproto/NeoMessages.options
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 6 - ((1 * winheight(0) + 2) / 4)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
6
normal! 0
wincmd w
argglobal
edit neolib/build_debug/NeoMessages.pb.h
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 2684 - ((20 * winheight(0) + 31) / 63)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
2684
normal! 073|
wincmd w
exe '1resize ' . ((&lines * 58 + 32) / 65)
exe 'vert 1resize ' . ((&columns * 95 + 101) / 203)
exe '2resize ' . ((&lines * 4 + 32) / 65)
exe 'vert 2resize ' . ((&columns * 95 + 101) / 203)
exe 'vert 3resize ' . ((&columns * 107 + 101) / 203)
tabedit neocommonproto/PancamMessages.proto
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 101 + 101) / 203)
exe '2resize ' . ((&lines * 31 + 32) / 65)
exe 'vert 2resize ' . ((&columns * 101 + 101) / 203)
exe '3resize ' . ((&lines * 31 + 32) / 65)
exe 'vert 3resize ' . ((&columns * 101 + 101) / 203)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 35 - ((34 * winheight(0) + 31) / 63)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
35
normal! 0
wincmd w
argglobal
edit neofirmware/Jaunt/Proto/PancamMessages.pb.h
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 25 - ((14 * winheight(0) + 15) / 31)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
25
normal! 05|
wincmd w
argglobal
edit neolib/build_debug/PancamMessages.pb.h
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 149 - ((11 * winheight(0) + 15) / 31)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
149
normal! 09|
wincmd w
exe 'vert 1resize ' . ((&columns * 101 + 101) / 203)
exe '2resize ' . ((&lines * 31 + 32) / 65)
exe 'vert 2resize ' . ((&columns * 101 + 101) / 203)
exe '3resize ' . ((&lines * 31 + 32) / 65)
exe 'vert 3resize ' . ((&columns * 101 + 101) / 203)
tabedit neofirmware/Jaunt/Camera/UsbControlFileIO.c
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 477 - ((40 * winheight(0) + 31) / 63)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
477
normal! 019|
tabedit neofirmware/Jaunt/Camera/UsbControl.c
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 17 - ((16 * winheight(0) + 31) / 63)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
17
normal! 0
tabedit neofirmware/Jaunt/CommandProc/UsbResponses.c
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 27 - ((15 * winheight(0) + 31) / 63)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
27
normal! 048|
tabnext 3
set stal=1
if exists('s:wipebuf')
"   silent exe 'bwipe ' . s:wipebuf
endif
" unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save

" Support for special windows like quick-fix and plug-in windows.
" Everything down here is generated by vim-session (not supported
" by :mksession out of the box).

1wincmd w
tabnext 3
if exists('s:wipebuf')
  if empty(bufname(s:wipebuf))
if !getbufvar(s:wipebuf, '&modified')
  let s:wipebuflines = getbufline(s:wipebuf, 1, '$')
  if len(s:wipebuflines) <= 1 && empty(get(s:wipebuflines, 0, ''))
    silent execute 'bwipeout' s:wipebuf
  endif
endif
  endif
endif
doautoall SessionLoadPost
unlet SessionLoad
" vim: ft=vim ro nowrap smc=128
