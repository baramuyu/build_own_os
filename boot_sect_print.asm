print:
	pusha

start:
	mov al, [bx] ; 'bx' is base address of the strings
	cmp al, 0
	je done

	mov ah, 0x0e ; tty mode
	int 0x10 ; al has already the char

	add bx, 1 ; increment pointer
	jmp start

done:
	popa
	ret


print_nl:
	pusha

	mov ah, 0x0e ; tty mode
	mov al, 0x0a ; newline char
	int 0x10
	mov al, 0x0d ; carriage return
	int 0x10

	popa
	ret
	

