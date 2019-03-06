// gcc -m32 -fno-pie -ffreestanding -c kernel.c -o kernel.o

#include "../drivers/ports.h"

void main()
{
	// screen cursor position: ask VGA control register(0x3d4) for bytes
	// 14 = high byte of cursor and 15 low byte of cursor
	port_byte_out(0x3d4, 14);

	// data is returned in VGA data register (0x3d5)
	int position = port_byte_in(0x3d5);
	position += port_byte_in(0x3d5);


	int offset_from_vga = position * 2;



	char* vga = (char *)0xb8000;
	vga[offset_from_vga] = 'X';
	vga[offset_from_vga+1] = 0x0f;
}