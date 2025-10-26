.686
.model flat

public _main

extern _MessageBoxA@16	: PROC
extern _fopen:PROC, _fread:PROC, _fclose:PROC
extern _ExitProcess@4	:PROC

.data
	nazwa_pliku db 'C:\Users\ratko\Documents\Studia\3 semestr\AKO\Lab2\Projekt\Lab_2_projekt\Debug\plik.txt', 0
	tytul db 'Teskt wielkimi literami: ', 0
	tytul_blad db 'Nie udalo sie otworzyc pliku', 0
	mode db "r", 0
	bufor db 4 dup (0)
	wynik db 4 dup (0)

.code
_main PROC
	;open
	push offset mode
	push offset nazwa_pliku
	call _fopen
	add esp, 8
	cmp eax, 0
	je blad_plik

	;read
	push eax ;dla fclose
	push eax
	push 4
	push 1
	push offset bufor
	call _fread
	add esp, 16
	mov byte ptr [bufor + eax], 0

	;close
	call _fclose
	add esp, 4

	;rejestry wskaznikowe
	mov esi, 0
	mov edi, 0
	mov ecx, 4

	petla:
		cmp bufor[esi], 'a'
		jb dalej
		sub bufor[esi], 20h
		mov bl, bufor[esi]
		mov wynik[edi], bl
		
		add esi, 1
		add edi, 1
		sub ecx, 1
		jmp koniec_petli
		dalej:
			mov bl, bufor[esi]
			mov wynik[edi], bl

			add esi, 1
			add edi, 1
			sub ecx, 1
		koniec_petli:
			cmp ecx, 0
			jne petla

	push 4
	push offset tytul
	push offset wynik
	push 0
	call _MessageBoxA@16
	add esp, 16

	jmp koniec

	blad_plik:
		push 16
		push offset tytul_blad
		push offset nazwa_pliku
		push 0
		call _MessageBoxA@16
		add esp, 16

		jmp koniec

	koniec:
		push 0
		call _ExitProcess@4


_main ENDP


END