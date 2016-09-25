all: part1.o border.o
	gcc part1.o border.o -o part1.out

part1.o: part1.c
	gcc -c part1.c
	
border.o: border.asm
	yasm -f elf64 -g dwarf2 border.asm -o border.o

run: 
	./part1.out

