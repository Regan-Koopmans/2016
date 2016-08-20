make:
	yasm -f elf64 -g dwarf2 -l div.lst div.asm
	ld div.o -o div

run:
	./div

clean:
	rm *.o *.lst

debug:
	cgdb div
