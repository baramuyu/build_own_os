# $@ = target file
# $< = first dependency
# $^ = all dependencies

C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

# replace file extension
OBJ = ${C_SOURCES:.c=.o}

# -g: debugging symbols in gcc
CFLAG = -g

# first one always run by defalt
os-image.bin: boot/bootsect.bin kernel.bin
	cat $^ > $@

kernel.bin: boot/kernel_entry.o ${OBJ}
	ld -m elf_i386 -s -o $@ -Ttext 0x1000 $^ --oformat binary

kernel.elf: boot/kernel_entry.o ${OBJ}
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^

run: os-image.bin
	qemu-system-i386 -fda $<

# not working for now
debug: os-image.bin kernel.elf
	qemu-system-i386 -fda $< & ${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

%.o: %.c ${HEADERS}
	gcc ${CFLAGS} -m32 -fno-pie -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm -rf *.bin *.dis *.o os-image.bin *.elf
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o

kernel.dis : kernel.bin
	ndisasm -b 32 $< > $@
