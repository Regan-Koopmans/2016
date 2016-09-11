# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif


all: task4.o findLargest.o
	gcc task4.o findLargest.o -o task4.out -m64 -static

task4.o: task4.c
	gcc -c task4.c -m64
	
findLargest.o: findLargest.asm
	yasm -f elf64 -g dwarf2 findLargest.asm -o findLargest.o

run: 
	./task1.out $(RUN_ARGS)

