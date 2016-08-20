make:
	yasm -f elf64 -g dwarf2 -l sub.lst sub.asm
	ld sub.o -o sub

run:
	./sub

clean:
	rm *.o *.lst

debug:
	cgdb sub
