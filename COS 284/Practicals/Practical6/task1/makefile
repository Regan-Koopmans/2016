# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif


all: main.o allocateNode.o linkNodes.o
	gcc main.o linkNodes.o allocateNode.o -g -o prog.out -m64 -lm -static

main.o: main.c
	gcc -c -g main.c -m64

linkNodes.o: linkNodes.asm
	yasm -f elf64 -g dwarf2 linkNodes.asm -o linkNodes.o

allocateNode.o: allocateNode.asm
	yasm -f elf64 -g dwarf2 allocateNode.asm -o allocateNode.o

run:
	./prog.out $(RUN_ARGS)
