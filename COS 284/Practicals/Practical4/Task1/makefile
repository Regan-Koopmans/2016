# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif


all: task1.o pseudoRC.o
	gcc task1.o pseudoRC.o -o task1.out -m64 -static

task1.o: task1.c
	gcc -c task1.c -m64
	
pseudoRC.o: pseudoRC.asm
	yasm -f elf64 -g dwarf2 pseudoRC.asm -o pseudoRC.o

run: 
	./task1.out $(RUN_ARGS)

