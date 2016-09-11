# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif


all: task2.o dotProduct.o
	gcc task2.o dotProduct.o -o task2.out -m64 -lm -static

task2.o: task2.c
	gcc -c task2.c -m64
	
dotProduct.o: dotProduct.asm
	yasm -f elf64 -g dwarf2 dotProduct.asm -o dotProduct.o

run: 
	./task2.out $(RUN_ARGS)

