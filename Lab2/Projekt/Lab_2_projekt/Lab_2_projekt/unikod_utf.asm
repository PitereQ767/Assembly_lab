.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC

public _main

.data
	wynik dw 10 dup (?), 10
	tytul dw 'E','m','o','j','i',':', 10

.code
_main PROC
	mov eax, 0 ;wyzerowanie
	mov eax, 1FABFh
	sub eax, 10000h
	shl eax, 6
	shr ax, 6

	mov edi, 0

	add ax, 1101110000000000b
	mov wynik[edi + 2], ax

	shr eax, 16
	add ax, 1101100000000000b
	mov wynik[edi], ax

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