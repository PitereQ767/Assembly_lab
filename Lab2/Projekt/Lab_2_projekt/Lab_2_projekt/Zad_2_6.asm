; wczytywanie i wyœwietlanie tekstu wielkimi literami 
; (inne znaki siê nie zmieniaj¹) 
.686 
.model flat 

extern  _ExitProcess@4 : PROC 
extern  __write : PROC  ; (dwa znaki podkreœlenia) 
extern  __read  : PROC  ; (dwa znaki podkreœlenia) 
extern _MessageBoxA@16   : PROC

public  _main 

.data 
    tekst_pocz  db 10, 'Proszê napisaæ jakiœ tekst ' 
                db 'i nacisnac Enter', 10 
    koniec_t    db  ? ; Etykieta do obliczenia d³ugoœci tekstu
    
    magazyn     db 80 dup (?) 
    nowa_linia  db 10       ; Ta zmienna nie jest u¿ywana w kodzie
    liczba_znakow dd ? 
    tytul db 'Komunikat', 0

.code 
_main PROC 
    ; wyœwietlenie tekstu informacyjnego 
    mov     ecx, (OFFSET koniec_t) - (OFFSET tekst_pocz) ; liczba znaków tekstu
    push    ecx 
    push    OFFSET tekst_pocz   ; adres tekstu 
    push    1                   ; nr urz¹dzenia (tu: ekran - nr 1) 
    call    __write             ; wyœwietlenie tekstu pocz¹tkowego 
    add     esp, 12             ; usuniecie parametrów ze stosu 

    ; czytanie wiersza z klawiatury 
    push    80                  ; maksymalna liczba znaków 
    push    OFFSET magazyn 
    push    0                   ; nr urz¹dzenia (tu: klawiatura - nr 0) 
    call    __read              ; czytanie znaków z klawiatury 
    add     esp, 12             ; usuniecie parametrów ze stosu 

    ; funkcja read wpisuje do EAX liczbê wprowadzonych znaków 
    mov     liczba_znakow, eax 

    ; rejestr ECX pe³ni rolê licznika obiegów pêtli 
    mov     ecx, eax 
    mov     ebx, 0              ; indeks pocz¹tkowy 
ptl:       
    mov     dl, magazyn[ebx]    ; pobranie kolejnego znaku 
    cmp     dl, 'a' 
    jb      dalej               ; skok, gdy znak nie wymaga zamiany 
    ;cmp     dl, 'z' 
    ;ja      dalej               ; skok, gdy znak nie wymaga zamiany 
    
    cmp dl, 0a5h
    jne litera_e
    mov byte ptr magazyn[ebx], 0b9h
    jmp dalej

litera_e:
    cmp dl, 0a9h
    jne litera_c
    mov byte ptr magazyn[ebx], 0eah
    jmp dalej

litera_c:
    cmp dl, 86h
    jne litera_l
    mov byte ptr magazyn[ebx], 0e6h
    jmp dalej

litera_l:
    cmp dl, 88h
    jne litera_n
    mov byte ptr magazyn[ebx], 0b3h
    jmp dalej

litera_n:
    cmp dl, 0e4h
    jne litera_o
    mov byte ptr magazyn[ebx], 0f1h
    jmp dalej

litera_o:
    cmp dl, 0a2h
    jne litera_s
    mov byte ptr magazyn[ebx], 0f3h
    jmp dalej

litera_s:
    cmp dl, 98h
    jne litera_x
    mov byte ptr magazyn[ebx], 9ch
    jmp dalej

litera_x:
    cmp dl, 0abh
    jne litera_z
    mov byte ptr magazyn[ebx], 9fh
    jmp dalej

litera_z:
    cmp dl, 0a8h
    jne duze_A
    mov byte ptr magazyn[ebx], 0bfh
    jmp dalej

duze_A:
    cmp dl, 0a4h
    jne duze_E
    mov byte ptr magazyn[ebx], 0a5h
    jmp dalej

;wielkie litery
duze_E:
    cmp dl, 0a8h
    jne duze_C
    mov byte ptr magazyn[ebx], 0cah
    jmp dalej

duze_C:
    cmp dl, 8fh
    jne duze_L
    mov byte ptr magazyn[ebx], 0c6h
    jmp dalej

duze_L:
    cmp dl, 9dh
    jne duze_N
    mov byte ptr magazyn[ebx], 0a3h
    jmp dalej

duze_N:
    cmp dl, 0e3h
    jne duze_O
    mov byte ptr magazyn[ebx], 0d1h
    jmp dalej

duze_O:
    cmp dl, 0e0h
    jne duze_S
    mov byte ptr magazyn[ebx], 0d3h
    jmp dalej

duze_S:
    cmp dl, 97h
    jne duze_X
    mov byte ptr magazyn[ebx], 8ch
    jmp dalej

duze_X:
    cmp dl, 8dh
    jne duze_Z
    mov byte ptr magazyn[ebx], 8fh
    jmp dalej

duze_Z:
    cmp dl, 0bdh
    jne dalej
    mov byte ptr magazyn[ebx], 0afh
    
    
    ;sub     dl, 20H             ; zamiana na wielkie litery 
    mov     magazyn[ebx], dl    ; odes³anie znaku do pamiêci 
dalej:     
    inc     ebx ; inkrementacja indeksu 
    dec ecx
    jnz ptl               ; sterowanie pêtl¹ 

    push 0
    push offset tytul
    push offset magazyn
    push 0
    call _MessageBoxA@16
    add esp, 16


    ; zakoñczenie programu 
    push    0 
    call    _ExitProcess@4      
    
_main ENDP 
END