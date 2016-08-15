make:
	yasm -f elf64 -g dwarf2 -l task2.lst task2.asm
	ld task2.o -o task2

run:
	./task2

clean:
	rm *.o *.lst

debug:
	cgdb task2
