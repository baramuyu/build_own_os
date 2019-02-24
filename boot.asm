; > nasm -f bin boot.asm -o boot.bin
; > qemu-system-i386 boot.bin

;[org 0x7c00]

mov ah, 0x0e ; tty mode

mov bp, 0x8000 ;
mov sp, bp

push 'A'
push 'B'
push 'C'

pop bx
mov al, bl
int 0x10 ; 'C' [0x7ffa]

pop bx
mov al, bl
int 0x10 ; 'B' [0x7ffc]

mov al, [0x7ffe] ; show 'A'
int 0x10

pop bx
mov al, bl
int 0x10 ; 'A' [0x7ffe]

jmp $ ; jump to current address -> loop

times 510-($-$$) db 0
dw 0xaa55
 	