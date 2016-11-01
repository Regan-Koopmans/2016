all: part2.o crop.o
	gcc part2.o crop.o -o part2.out


part2.o: part2.c
	gcc -c part2.c

crop.o: crop.asm
	yasm -f elf64 -g dwarf2 crop.asm -o crop.o

run:
	./part2.out

