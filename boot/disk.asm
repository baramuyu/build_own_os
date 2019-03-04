; load 'dh' sectors from drive 'dl' into ES:BX
disk_load:
	pusha

	push dx

	mov ah, 0x02 ; ah: 'read' mode, -> int 0x13
	mov al, dh   ; al: number of sectors to read
	mov cl, 0x02 ; cl read sector. 0x01 is boot sector, 0x02 is the first 'available' sector
	mov ch, 0x00 ; ch, cylinder
	mov dh, 0x00 ; dh head number

	int 0x13     ; BIOS interrupt
	jc disk_error

	pop dx
	cmp al, dh   ; BIOS also sets 'al' to the # of sectors read.
	jne sectors_error
	popa
	ret

disk_error:
	mov bx, DISK_ERROR
	call print
	call print_nl
	mov dh, ah ; ah = error code, dl = disk drive that dropped the error
	call print_hex
	jmp disk_loop

sectors_error:
	mov bx, SECTORS_ERROR
	call print

disk_loop:
	jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0