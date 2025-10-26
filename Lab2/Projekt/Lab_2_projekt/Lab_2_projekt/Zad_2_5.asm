; wczytywanie i wyœwietlanie tekstu wielkimi literami 
; (inne znaki siê nie zmieniaj¹) 
.686 
.model flat 

extern  _ExitProcess@4 : PROC 
extern  __write : PROC  ; (dwa znaki podkreœlenia) 
extern  __read  : PROC  ; (dwa znaki podkreœlenia) 

public  _main 

.data 
    tekst_pocz  db 10, 'Proszê napisaæ jakiœ tekst ' 
                db 'i nacisnac Enter', 10 
    koniec_t    db  ? ; Etykieta do obliczenia d³ugoœci tekstu
    
    magazyn     db 80 dup (?) 
    nowa_linia  db 10       ; Ta zmienna nie jest u¿ywana w kodzie
    liczba_znakow dd ? 

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
    mov byte ptr magazyn[ebx], 0a4h
    jmp dalej

litera_e:
    cmp dl, 0a9h
    jne litera_c
    mov byte ptr magazyn[ebx], 0a8h
    jmp dalej

litera_c:
    cmp dl, 86h
    jne litera_l
    mov byte ptr magazyn[ebx], 8fh
    jmp dalej

litera_l:
    cmp dl, 0b3h
    jne litera_n
    mov byte ptr magazyn[ebx], 0a3h
    jmp dalej

litera_n:
    cmp dl, 0e4h
    jne litera_o
    mov byte ptr magazyn[ebx], 0e3h
    jmp dalej

litera_o:
    cmp dl, 0a2h
    jne litera_s
    mov byte ptr magazyn[ebx], 0e0h
    jmp dalej

litera_s:
    cmp dl, 98h
    jne litera_x
    mov byte ptr magazyn[ebx], 97h
    jmp dalej

litera_x:
    cmp dl, 0abh
    jne litera_z
    mov byte ptr magazyn[ebx], 8dh
    jmp dalej

litera_z:
    cmp dl, 0beh
    jne dalej
    mov byte ptr magazyn[ebx], 0bdh
    
    
    sub     dl, 20H             ; zamiana na wielkie litery 
    mov     magazyn[ebx], dl    ; odes³anie znaku do pamiêci 
dalej:     
    inc     ebx ; inkrementacja indeksu 
    dec ecx
    jnz ptl               ; sterowanie pêtl¹ 

    ; wyœwietlenie przekszta³conego tekstu 
    push    liczba_znakow 
    push    OFFSET magazyn 
    push    1 
    call    __write             ; wyœwietlenie przekszta³conego tekstu 
    add     esp, 12             ; usuniecie parametrów ze stosu 

    ; zakoñczenie programu 
    push    0 
    call    _ExitProcess@4      
    
_main ENDP 
END