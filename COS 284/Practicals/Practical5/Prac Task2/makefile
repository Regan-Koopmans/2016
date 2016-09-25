all: task2.o shaper.o
	gcc task2.o shaper.o -o task2.out

task2.o: task2.c
	gcc -c task2.c
	
shaper.o: shaper.asm
	yasm -f elf64 -g dwarf2 shaper.asm -o shaper.o

run: 
	./task2.out

