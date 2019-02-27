# $@ = target file
# $< = first dependency
# $^ = all dependencies

all: run

kernel.bin: kernel_entry.o kernel.o
	ld -m elf_i386 -s -o $@ -Ttext 0x1000 $^ --oformat binary

kernel.o: kernel.c
	gcc -m32 -fno-pie -ffreestanding -c $< -o $@

kernel_entry.o: kernel_entry.asm
	nasm $< -f elf -o $@

bootsect.bin: bootsect.asm
	nasm $< -f bin -o $@

os-image.bin: bootsect.bin kernel.bin
	cat $^ > $@

run: os-image.bin
	qemu-system-i386 -fda $<

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@

clean:
	rm *.bin *.o *.dis