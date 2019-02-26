; > nasm -f bin boot_sect_segmentation.asm -o boot.bin
; > qemu-system-i386 boot.bin

mov ah, 0x0e ; tty

; < case 1 >
mov al, [the_secret]
int 0x10

mov bx, 0x7c0 ;<-- the segment is automatically <<4 for you... becomes 0x7c00
mov ds, bx ; 'ds' is Data Segment
; WARNING: from now on all memory references will be offset by 'ds' implicitly

; < case 2 >  
mov al, [es:the_secret] ; [segment: offset]
int 0x10 ; doesn't look right

; < case 3 >
; A = A 64k segment B = Offset within the segment
mov bx, 0x7c0
mov es, bx ; 'es' is extra segment
mov al, [es:the_secret]
int 0x10

jmp $

the_secret:
    db "X"

times 510 - ($-$$) db 0
dw 0xaa55