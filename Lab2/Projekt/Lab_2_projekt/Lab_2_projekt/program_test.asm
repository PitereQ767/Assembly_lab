.686
.model flat

extern _ExitProcess@4	: PROC

public _main

.data
	zmienna dd 30


.code
_main PROC
	mov eax, offset zmienna
	mov ebx, [eax]

	push 0
	call _ExitProcess@4

_main ENDP

END