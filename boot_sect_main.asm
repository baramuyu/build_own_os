; > nasm -f bin boot_sect_main.asm -o boot.bin
; > qemu-system-i386 boot.bin

[org 0x7c00]

	mov bp, 0x8000  ; set the stack safely away from us
	mov sp, bp

	mov bx, 0x9000
	mov dh, 3
	call disk_load

	mov dx, [0x9000] ; retrieve the first loaded word, 0xdada
	call print_hex

	call print_nl

	mov dx, [0x9000 + 512] ; first word from second loaded sector 0xface
	call print_hex
	call print_nl

	mov dx, [0x9000 + 1024] ; first word from second loaded sector 0xface
	call print_hex

	jmp $

%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"
%include "boot_sect_disk.asm"

times 510-($-$$) db 0
dw 0xaa55
 
times 256 dw 0xda01 ; sector 2 = 512 bytes
times 256 dw 0xfa02 ; sector 3 = 512 bytes
times 256 dw 0xaa03 ; sector 4 = 512 bytes

