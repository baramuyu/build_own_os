; receiving the data in 'dx'

; 0-9: '0' (ASCII 0x30) to '9' (0x39)
; add 0x30 to byte N.

; A-F: 'A' (ASCII 0x41) to 'F' (0x46)
; add 0x40

print_hex:
	pusha

	mov cx, 0;  index

hex_loop:
	cmp cx, 4 ; loop four times
	je end

	; convert dx to ascii
	mov ax, dx
	and ax, 0x000f ; 0x1234 -> 0x0004 by masking first three to zeros
	add al, 0x30   ; add 0x30 to N to convert it to ASCII "N"
	cmp al, 0x39   ; if al > 9(0x39), add extra 8
	jle step2
	add al, 7      ; 'A' is ASCII 65 instead of 58, so 65-58=7

step2:
	; get correct position of the string to place our ASCII char

	mov bx, HEX_OUT + 5 ; base + length
	sub bx, cx          ; our index variable
	mov [bx], al
	ror dx, 4 ; 0x1234 -> 0x4123 -> 0x3412 -> 0x2341 -> 0x1234

	add cx, 1           ; increment index and loop
	jmp hex_loop

end:
	mov bx, HEX_OUT     ; remember that print receives parameters in 'bx'
	call print

	popa 
	ret

HEX_OUT:
	db '0x0000', 0