; > nasm -f bin boot.asm -o boot.bin
; > qemu-system-i386 boot.bin

[org 0x7c00]

mov ah, 0x0e
int 0x10
mov bx, the_secret
mov al, [bx]
int 0x10

jmp $ ; jump to current address -> loop

the_secret:
	db "X"

times 510-($-$$) db 0
dw 0xaa55
