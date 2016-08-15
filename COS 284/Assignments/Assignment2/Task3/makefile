make:
	yasm -f elf64 -g dwarf2 -l task3.lst task3.asm
	ld task3.o -o task3

run:
	./task3

clean:
	rm *.o *.lst

debug:
	cgdb task3
