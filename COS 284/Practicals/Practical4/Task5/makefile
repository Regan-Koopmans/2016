# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif


all: task5.o .o
	gcc task5.o recursive.o -o task5.out -m64 -static

task5.o: task5.c
	gcc -c task5.c -m64
	
recursive.o: recursive.asm
	yasm -f elf64 -g dwarf2 recursive.asm -o recursive.o

run: 
	./task5.out $(RUN_ARGS)

