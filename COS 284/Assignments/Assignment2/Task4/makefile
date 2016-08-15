make:
	yasm -f elf64 -g dwarf2 -l task4.lst task4.asm
	ld task4.o -o task4

run:
	./task4

clean:
	rm *.o *.lst

debug:
	cgdb task4
