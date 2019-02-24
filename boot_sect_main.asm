; > nasm -f bin boot_sect_main.asm -o boot.bin
; > qemu-system-i386 boot.bin

[org 0x7c00]

mov bx, HELLO
call print

call print_nl

mov bx, GOODBYE
call print

call print_nl

mov dx, 0x12fe
call print_hex  ; print '0x12fe'

jmp $ ; jump to current address -> loop

%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"

HELLO:
	db 'Hello, World', 0 ; 0 means end of strings

GOODBYE:
	db 'Goodbye', 0

times 510-($-$$) db 0
dw 0xaa55
 	