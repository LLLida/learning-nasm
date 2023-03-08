;;; some string functions

;;; Returns length of string
strlen:
        push ebx
        mov     ebx, eax
.nextchar:
        cmp     byte [eax], 0
        jz      .finished
        inc     eax
        jmp     .nextchar
.finished:
        sub     eax, ebx
        pop      ebx
        ret

;;; prints a string to STDOUT
print:
        push edx
        push ecx
        push ebx
        push eax

        call strlen

        mov edx, eax
        pop eax

        mov ecx, eax
        mov ebx, 1              ; 1 -> STDOUT
        mov eax, 4              ; 4 -> print
        int 80h

        pop ebx
        pop ecx
        pop edx
        ret

;;; prints a string with linefeed
println:
        call print

        push eax
        mov eax, 0Ah
        push eax
        mov eax, esp
        call print
        pop eax
        pop eax
        ret

;;; prints an integer in decimal format
iprint:
        push eax
        push ecx
        push edx
        push esi
        mov ecx, 0

.loop:
        inc ecx
        mov edx, 0
        mov esi, 10
        idiv esi
        add edx, 48
        push edx
        cmp eax, 0
        jnz .loop
.print:
        dec ecx
        mov eax, esp
        call print
        pop eax
        cmp ecx, 0
        jnz .print

        pop esi
        pop edx
        pop ecx
        pop eax
        ret

;;; converts a string to integer
;;; NOTE: I feel like it could've been done better
atoi:
        push ebx
        push ecx
        push edx
        push esi

        mov esi, eax
        mov eax, 0
        mov ecx, 0

.loop:
        xor ebx, ebx
        mov bl, [esi+ecx]

        ;; bounds checking
        cmp bl, 48              ; compare to '0'
        jl .finished
        cmp bl, 57              ; compare to '9'
        jg .finished

        sub bl, 48              ; convert digit in ebx to integer
        add eax, ebx
        mov ebx, 10
        mul ebx
        inc ecx
        jmp .loop

.finished:
        cmp ecx, 0
        je .restore
        mov ebx, 10
        div ebx

.restore:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
