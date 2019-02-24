;nasm -f bin boot.asm -o boot.bin

mov ah, 0x0e; switchtty mode
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10 ; repeat 'l'
mov al, 'o'
int 0x10

jmp $ ; jump to current address -> loop

times 510-($-$$) db 0
dw 0xaa55
