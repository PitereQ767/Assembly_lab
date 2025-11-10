.686
.model flat

extern _ExitProcess@4	: PROC
extern _MessageBoxW@16	:PROC

public _main

.data
	zmienna dw 0d83ch, 0df19h, 0
	tytul dw 't', 'y', 't', 'u', 'l', 0


.code
_main PROC
	push 0
	push offset tytul
	push offset zmienna
	push 0
	call _MessageBoxW@16
	add esp, 16

	push 0
	call _ExitProcess@4

_main ENDP

END