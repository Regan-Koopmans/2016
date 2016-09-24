all: task1.o encode.o
	gcc task1.o encode.o -o task1.out

task1.o: task1.c
	gcc -c task1.c
	
encode.o: encode.asm
	yasm -f elf64 -g dwarf2 encode.asm -o encode.o

run: 
	./task1.out

