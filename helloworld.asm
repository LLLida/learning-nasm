; Hello World Program - asmtutor.com
; Compile with: nasm -f elf helloworld.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld.o -o helloworld
; Run with: ./helloworld

SECTION .data
msg1    db      'You have to play en passant when available!', 0h
msg2    db      'Hikaru says so!', 0h

SECTION .bss
sinput: resb 255

SECTION .text
global  _start

%include 'string_functions.asm'

_start:

        ;; print args
        pop ecx
next_arg:
        cmp ecx, 0h
        jz no_more_args
        pop eax
        call println
        dec ecx
        jmp next_arg
no_more_args:

        mov     eax, msg1
        call    println

        mov     eax, msg2
        call    println

        ;; input a string
        mov edx, 255
        mov ecx, sinput
        mov ebx, 0              ; 0 -> STDIN
        mov eax, 3
        int 80h

        ;; print input
        mov eax, sinput
        call print

        ;; print numbers from 0 to 20
        mov     ecx, 0
next_number:
        inc     ecx
        mov     eax, ecx
        call    iprint
        ;; print '\n'
        mov eax, 0Ah
        push eax
        mov eax, esp
        call print
        pop eax
        cmp     ecx, 20
        jne     next_number

        ;; exit(0)
        mov     ebx, 0
        mov     eax, 1          ; 1 -> STDOUT
        int     80h
