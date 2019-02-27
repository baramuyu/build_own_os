// gcc -m32 -fno-pie -ffreestanding -c kernel.c -o kernel.o

void dummy_test_entrypoint(){

}

void main()
{
	char* video_memory = (char*) 0xb8000;
	*video_memory = 'X';
}