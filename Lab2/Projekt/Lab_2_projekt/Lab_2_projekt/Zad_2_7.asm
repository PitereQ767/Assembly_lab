; wczytywanie i wyœwietlanie tekstu wielkimi literami 
; (inne znaki siê nie zmieniaj¹) 
.686 
.model flat 

extern  _ExitProcess@4 : PROC 
extern  __write : PROC  ; (dwa znaki podkreœlenia) 
extern  __read  : PROC  ; (dwa znaki podkreœlenia) 
extern _MessageBoxA@16   : PROC
extern _MessageBoxW@16  : PROC

public  _main 

.data 
    tekst_pocz  db 10, 'Proszê napisaæ jakiœ tekst ' 
                db 'i nacisnac Enter', 10 
    koniec_t    db  ? ; Etykieta do obliczenia d³ugoœci tekstu
    
    magazyn     db 80 dup (?) 
    nowa_linia  db 10       ; Ta zmienna nie jest u¿ywana w kodzie
    liczba_znakow dd ? 
    tytul db 'Komunikat ANSI', 0
    wynik_16_bit dw 120 dup (0)
    tytul_unicode dw 'K', 'o', 'm', 'u', 'n', 'i', 'k', 'a', 't', ' ', 'M', 'e', 's', 's', 'a', 'g', 'e', 'B', 'o', 'x', 'W', 0

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
    cmp dl, 0beh
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
    jnz ptl         ; sterowanie pêtl¹ 

    
    ;konwersja na 
    mov ecx, liczba_znakow
    mov ebx, 0
    mov edi, offset wynik_16_bit

konwersja:
    movzx eax, byte ptr magazyn[ebx]

    mov dx, ax

    cmp al, 0b9h
    jne _e
    mov dx, 0105h
    jmp zapisz

_e:
    cmp al, 0eah
    jne _c
    mov dx, 0119h
    jmp zapisz 
_c:
    cmp al, 0e6h
    jne _l
    mov dx, 0107h
    jmp zapisz

_l:
    cmp al, 0b3h
    jne _n
    mov dx, 0142h
    jmp zapisz
_n:
    cmp al, 0f1h
    jne _o
    mov dx, 0144h
    jmp zapisz
_o:
    cmp al, 0f3h
    jne _s
    mov dx, 00f3h
    jmp zapisz
_s:
    cmp al, 9ch
    jne _x
    mov dx, 015bh
    jmp zapisz
_x:
    cmp al, 9fh
    jne _z
    mov dx, 017ah
    jmp zapisz
_z:
    cmp al, 0bfh
    jne _a_2
    mov dx, 017ch
    jmp zapisz

_a_2:
    cmp al, 0a5h
    jne _e_2
    mov dx, 0104h
    jmp zapisz
_e_2:
    cmp al, 0cah
    jne _c_2
    mov dx, 0118h
    jmp zapisz
_c_2:
    cmp al, 0c6h
    jne _l_2
    mov dx, 0106h
    jmp zapisz
_l_2:
    cmp al, 0a3h
    jne _n_2
    mov dx, 0141h
    jmp zapisz
_n_2:
    cmp al, 0d1h
    jne _o_2
    mov dx, 0143h
    jmp zapisz
_o_2:
    cmp al, 0d3h
    jne _s_2
    mov dx, 00d3h
    jmp zapisz
_s_2:
    cmp al, 8ch
    jne _x_2
    mov dx, 015ah
    jmp zapisz
_x_2:
    cmp al, 8fh
    jne _z_2
    mov dx, 0179h
    jmp zapisz
_z_2:
    cmp al, 0afh
    jne zapisz
    mov dx, 017bh


zapisz:
    mov [edi], dx
    add edi, 2
    inc ebx
    sub ecx, 1
    jnz konwersja


    


    ;wyswietlanie
    push 0
    push offset tytul
    push offset magazyn
    push 0
    call _MessageBoxA@16
    add esp, 16

    push 0
    push offset tytul_unicode
    push offset wynik_16_bit
    push 0
    call _MessageBoxW@16
    add esp, 16


    ; zakoñczenie programu 
    push    0 
    call    _ExitProcess@4      
    
_main ENDP 
END