; > nasm -f bin bootsect.asm -o boot.bin
; > qemu-system-i386 boot.bin

[org 0x7c00]
KERNEL_OFFSET equ 0x1000

	mov [BOOT_DRIVE], dl ; BIOS sets us the boot drive in 'dl' on boot
	mov bp, 0x9000 ; set the stack
	mov sp, bp

	mov bx, MSG_REAL_MODE
	call print
	call print_nl

	call load_kernel  ; read the kernel from disk
	call switch_to_pm ; disable interrupts, load GDT... and jumps to 'BEGIN_PM' 
	jmp $ ; this will never be executed

%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"
%include "boot_sect_disk.asm"
%include "32bit-gdt.asm"
%include "32bit-print.asm"
%include "32bit-switch.asm"

[bits 16]
load_kernel:
	mov bx, MSG_LOAD_KERNEL
	call print
	call print_nl

	mov bx, KERNEL_OFFSET ; Read from disk and store in 0x1000
	mov dh, 2 ; how many sector you read
	mov dl, [BOOT_DRIVE]
	call disk_load
	ret

[bits 32]
BEGIN_PM: 
	mov ebx, MSG_PROT_MODE
	call print_string_pm
	call KERNEL_OFFSET ; give control to the kernel
	jmp $ ; stay here when the kernel returns control here

BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16 bit real mode", 0
MSG_PROT_MODE db "Loaded 32 bit protected mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

times 510-($-$$) db 0
dw 0xaa55