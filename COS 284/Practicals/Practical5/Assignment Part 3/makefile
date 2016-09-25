all: part3.o intensity.o
	gcc part3.o intensity.o -o part3.out

part3.o: part3.c
	gcc -c part3.c
	
intensity.o: intensity.asm
	yasm -f elf64 -g dwarf2 intensity.asm -o intensity.o

run: 
	./part3.out

