.PHONY: all

all: helloworld calculator

helloworld: helloworld.asm string_functions.asm
	nasm -f elf helloworld.asm
	ld -m elf_i386 helloworld.o -o helloworld

calculator: calculator.asm string_functions.asm
	nasm -f elf calculator.asm
	ld -m elf_i386 calculator.o -o calculator
