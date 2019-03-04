basic.o : basic.c
	gcc -ffreestanding -m32 -fno-pie -c $< -o $@

basic.bin : basic.o
	ld -o $@ -Ttext 0x0 --oformat binary $<

basic.dump : basic.o
	objdump -d $< > $@

basic.bin : basic.o
	ld -m elf_i386 -s -o $@ -Ttext 0x1000 $^ --oformat binary

basic.dis : basic.bin
	ndisasm -b 32 $< > $@
