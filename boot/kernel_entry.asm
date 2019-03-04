;ld -m elf_i386 -s -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary

[bits 32]
[extern main] ; Define calling point ... call main function on C code
call main ; call c function, linker will know where
jmp $