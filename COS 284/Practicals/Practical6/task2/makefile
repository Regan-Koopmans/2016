# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif


all: main.o calculateRoutes.o
	gcc main.o calculateRoutes.o -o prog.out -m64 -lm -static

main.o: main.c
	gcc -c main.c -m64
	
calculateRoutes.o: calculateRoutes.asm
	yasm -f elf64 -g dwarf2 calculateRoutes.asm -o calculateRoutes.o

run: 
	./prog.out $(RUN_ARGS)

