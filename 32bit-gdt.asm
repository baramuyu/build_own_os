gdt_start:
	; GDT start with a null 8 byte
	dd 0x0 ; 4 byte
	dd 0x0 ; 4 byte

; GDT for code segment. base = 0x0000000, length = 0xfffff
gdt_code:
	dw 0xffff   ; bits 0-15
	dw 0x0      ; bits 0-15
	db 0x0      ; bits 16-23
	db 10011010b ; flags 8 bits
	db 11001111b ; flags (4 bits)
	db 0x0      ; segment base, 24-31

; GDT for data segment
gdt_data:
	dw 0xffff
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0

gdt_end:

gdt_descriptor:
	dw gdt_end - gdt_start - 1 ; size
	dd gdt_start ; address (32 bit)

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
