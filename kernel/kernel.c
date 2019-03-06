// gcc -m32 -fno-pie -ffreestanding -c kernel.c -o kernel.o

#include "../drivers/screen.h"

void main()
{
	clear_screen();
	kprint_at("Y", 2, 2);
	kprint_at("Apache Spark is an open-source distributed general-purpose cluster-computing framework. ", 2, 4);
	kprint_at("Spark provides an interface for programming entire \nclusters with implicit data parallelism and fault tolerance.\n", 2, 7);
	kprint("\nthe Spark codebase was later donated to \nthe Apache Software Foundation.");
	kprint_at("What happens when we run out of space?", 45, 24);

}	