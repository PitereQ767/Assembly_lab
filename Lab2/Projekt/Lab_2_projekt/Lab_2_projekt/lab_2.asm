.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
extern __read : PROC
extern __write : PROC

public _main

.data
prompt      db 'Proszê wpisaæ jakiœ tekst:', 10
prompt_len  db ?

magazyn     db 256 dup(?)
wynik       dw 256 dup(?)
tytul       db 'W', 'y', 'n', 'i', 'k', 10
powrot      dd 0

.code
_main PROC
    mov eax, (offset prompt_len - offset prompt)

    push eax
    push offset prompt
    push 1
    call __write
    add esp, 12

    ; --- wczytanie tekstu ---
    push 256
    push offset magazyn
    push 0
    call __read
    add esp, 12

    mov ecx, eax
    ;mov magazyn[ecx-1], 0    ; usuñ znak nowej linii

    mov esi, 0               ; indeks Ÿród³a
    mov edi, 0               ; indeks celu

petla:
    mov al, magazyn[esi]
    cmp al, 0ah
    je koniec
    cmp al, 'U'
    je _U


    movzx bx, al
    mov wynik[edi], bx
    add edi, 2
    add esi, 1
    jmp petla

_U:
    mov al, magazyn[esi + 1]
    cmp al, '+'
    je _plus
    add esi, 1
    jmp petla

_plus: 
    mov al, magazyn[esi + 2]
    cmp al, '1'
    je _1
    add esi, 1
    jmp petla
_1:
    mov al, magazyn[esi + 3]
    cmp al, 'F'
    je _F
    add esi, 1
    jmp petla

_F:
    mov al, magazyn[esi + 4]
    cmp al, '3'
    je _3
    add esi, 1
    jmp petla

_3:
    mov al, magazyn[esi + 5]
    cmp al, '1'
    je _1_2
    add esi, 1
    jmp petla
_1_2:
    mov al, magazyn[esi + 6]
    cmp al, '9'
    je ksiezyc
    cmp al, 'E'
    je slonce
    mov wynik[edi], word ptr 'U'
    add edi, 2
    add esi, 1
    jmp petla

ksiezyc:
    mov wynik[edi], 0d83ch
    add edi, 2
    mov wynik[edi], 0df19h
    add edi, 2
    add esi, 7
    jmp petla

slonce:
    mov wynik[edi], 0d83ch
    add edi, 2
    mov wynik[edi], 0df1eh
    add edi, 2
    add esi, 7
    jmp petla   


    
    




koniec:
    ; --- pokazanie wyniku ---
    push 0
    push offset tytul
    push offset wynik
    push 0
    call _MessageBoxW@16
    add esp, 16

    push 0
    call _ExitProcess@4
_main ENDP
END
