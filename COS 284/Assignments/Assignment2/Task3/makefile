make:
	yasm -f elf64 -g dwarf2 -l mul.lst mul.asm
	ld mul.o -o mul

run:
	./mul

clean:
	rm *.o *.lst

debug:
	cgdb mul
