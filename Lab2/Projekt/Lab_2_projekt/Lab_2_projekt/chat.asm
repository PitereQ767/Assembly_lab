.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern __read : PROC
extern __write : PROC

public _main

.data
prompt      db 'Proszê wpisaæ jakiœ tekst:', 10
prompt_len  db ?

magazyn     db 256 dup(?)
wynik       db 256 dup(?)
tytul       db 'Wynik', 0

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
    mov magazyn[ecx-1], 0    ; usuñ znak nowej linii

    mov esi, 0               ; indeks Ÿród³a
    mov edi, 0               ; indeks celu
    mov ebx, 0               ; licznik s³ów
    mov edx, 0               ; pocz¹tek aktualnego s³owa

petla:
    mov al, magazyn[esi]
    cmp al, 0
    je koniec_przetwarzania
    cmp al, ' '
    je koniec_slowa
    inc esi
    jmp petla

koniec_slowa:
    mov eax, esi
    sub eax, edx
    cmp eax, 0
    jle pomin_spacje

    inc ebx
    test ebx, 1
    jnz kopiuj_normalnie
    jmp odwroc_slowa

kopiuj_normalnie:
    mov ecx, edx
kopiuj_petla:
    cmp ecx, esi
    jge kopiuj_koniec
    mov al, magazyn[ecx]
    mov wynik[edi], al
    inc edi
    inc ecx
    jmp kopiuj_petla

kopiuj_koniec:
    mov al, ' '
    mov wynik[edi], al
    inc edi
    inc esi
    mov edx, esi
    jmp petla

odwroc_slowa:
    mov ecx, esi
    dec ecx
odwroc_petla:
    cmp ecx, edx
    jl odwroc_koniec
    mov al, magazyn[ecx]
    mov wynik[edi], al
    inc edi
    dec ecx
    jmp odwroc_petla

odwroc_koniec:
    mov al, ' '
    mov wynik[edi], al
    inc edi
    inc esi
    mov edx, esi
    jmp petla

pomin_spacje:
    inc esi
    mov edx, esi
    jmp petla

koniec_przetwarzania:
    mov eax, esi
    sub eax, edx
    cmp eax, 0
    jle dalej

    inc ebx
    test ebx, 1
    jnz kopiuj_ostatnie
    jmp odwroc_ostatnie

kopiuj_ostatnie:
    mov ecx, edx
kop_ost_petla:
    cmp ecx, esi
    jge dalej
    mov al, magazyn[ecx]
    mov wynik[edi], al
    inc edi
    inc ecx
    jmp kop_ost_petla

odwroc_ostatnie:
    mov ecx, esi
    dec ecx
odwroc_ost_petla:
    cmp ecx, edx
    jl dalej
    mov al, magazyn[ecx]
    mov wynik[edi], al
    inc edi
    dec ecx
    jmp odwroc_ost_petla

dalej:
    mov byte ptr wynik[edi], 0

    ; --- pokazanie wyniku ---
    push 0
    push offset tytul
    push offset wynik
    push 0
    call _MessageBoxA@16
    add esp, 16

    push 0
    call _ExitProcess@4
_main ENDP
END
