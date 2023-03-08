;;; simple calculator

%include 'string_functions.asm'

SECTION .data
rem1 db ' remainder '

SECTION .text
global _start

_start:
        ;; iterate over arguments
        pop ecx
        pop edx
        sub ecx, 1
        mov edx, 0
.next_args:
        cmp ecx, 0h
        jz .no_more_args
        pop eax
        call atoi
        add edx, eax
        dec ecx
        jmp .next_args
.no_more_args:
        mov eax, edx
        call iprint
        mov eax, 0h
        push eax
        mov eax, esp
        call println
        pop eax

        mov eax, 90
        mov ebx, 9
        call printadd

        mov eax, 100
        mov ebx, 31
        call printsub

        mov eax, 42
        mov ebx, 987
        call printmul

        mov eax, 1001
        mov ebx, 76
        call printdiv

        ;; exit(0)
        mov     ebx, 0
        mov     eax, 1          ; 1 -> STDOUT
        int     80h

printadd:
        push eax
        push ebx

        add eax, ebx
        call iprint

        ;; print '\n'
        mov eax, 0Ah
        push eax
        mov eax, esp
        call print
        pop eax

        pop ebx
        pop eax
        ret

printsub:
        push eax
        push ebx

        sub eax, ebx
        call iprint

        ;; print '\n'
        mov eax, 0Ah
        push eax
        mov eax, esp
        call print
        pop eax

        pop ebx
        pop eax
        ret

printmul:
        push eax
        push ebx

        mul ebx
        call iprint

        ;; print '\n'
        mov eax, 0Ah
        push eax
        mov eax, esp
        call print
        pop eax

        pop ebx
        pop eax
        ret

printdiv:
        push eax
        push ebx

        div ebx
        call iprint

        ;; print 'remainder'
        mov eax, rem1
        call print
        mov eax, edx
        call iprint

        ;; print '\n'
        mov eax, 0Ah
        push eax
        mov eax, esp
        call print
        pop eax

        pop ebx
        pop eax
        ret
