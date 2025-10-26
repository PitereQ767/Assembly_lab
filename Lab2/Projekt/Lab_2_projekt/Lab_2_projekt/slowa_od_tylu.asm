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
    liczba_znakow dd ? 

    wynik_tytul dw 'O', 'd','w', 'r', 'o', 'c', 'o', 'n', 'y', ' ', 'c', 'i','a','g',' ','z','n','a','k','o','w', 10
    wynik dw 80 dup (?)

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

    mov ecx, liczba_znakow  ;okrazenia petli 
    mov esi, ecx 
    sub esi, 1
    mov edi, 0

petla:
    mov al, magazyn[ecx]
    mov ebx, ecx
    cmp ecx, 0
    je kopiowanie
    sub ecx, 1
    cmp al, 20h
    jne petla

kopiowanie:
    movzx dx, byte ptr magazyn[ebx]
    cmp dl, 20h
    je pomin_zapis
    mov wynik[edi], dx
    add edi, 2

pomin_zapis:
    add ebx, 1
    cmp ebx, esi
    jb kopiowanie

    mov wynik[edi], word ptr ' '
    add edi, 2


    mov esi, ecx
    add esi, 1
    cmp ecx, 0
    jne petla


    push 0
    push offset wynik_tytul
    push offset wynik
    push 0
    call _MessageBoxW@16

    push 0
    call _ExitProcess@4


_main ENDP

END