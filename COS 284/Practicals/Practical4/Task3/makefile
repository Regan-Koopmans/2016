# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif


all: task3.o swapNums.o
	gcc task3.o swapNums.o -o task3.out -m64 -lm -static

task3.o: task3.c
	gcc -c task3.c -m64
	
swapNums.o: swapNums.asm
	yasm -f elf64 -g dwarf2 swapNums.asm -o swapNums.o

run: 
	./task3.out $(RUN_ARGS)


clean:
	rm *.o
	rm *.out
