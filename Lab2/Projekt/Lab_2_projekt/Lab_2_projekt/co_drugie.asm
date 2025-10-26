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
    mov ecx, esi
    cmp al, 20h
    je druga_spacja
    movzx bx, magazyn[esi]
    mov wynik[edi], bx
    add esi, 1
    add edi, 2
    jmp petla

druga_spacja:
    add ecx, 1
    mov powrot, ecx
    cmp magazyn[ecx], 20h
    je kopiowanie
    cmp magazyn[ecx], 0ah
    je koniec_2
    jmp druga_spacja

kopiowanie:
    cmp ecx, esi
    je przypisanie
    movzx bx, magazyn[ecx]
    mov wynik[edi], bx
    add edi, 2
    sub ecx, 1
    jmp kopiowanie

przypisanie:
    mov esi, powrot
    add esi, 1
    mov wynik[edi], 20h
    add edi, 2
    jmp petla


koniec_2:
    mov magazyn[ecx], 20h
    ;sub ecx, 1
    jmp kopiowanie



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
