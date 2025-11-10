.686
.model flat

public _main

extern _ExitProcess@4:PROC, __write:PROC

.data
	dekoder db '0123456789ABCDEF'
	

.code
_wyswietl_EAX_hex PROC
	pusha
	sub esp, 12
	mov edi, esp

	mov ecx, 8
	mov esi, 1

petla:
	rol eax, 4
	mov ebx, eax
	and ebx, 0000000fh
	mov dl, dekoder[ebx]

	;zapis liczby do wyniku
	mov [edi][esi], dl
	add esi, 1
	loop petla

	;dodanie znaku poczatka lini na poczatku i koncu cyfry
	mov byte ptr [edi][0], 0ah
	mov byte ptr [edi][9], 0ah

	push 10
	push edi
	push 1
	call __write

	add esp, 24

	popa
	ret
_wyswietl_EAX_hex ENDP


_main PROC
	mov eax, 1234
	call _wyswietl_EAX_hex

	
	push 0
	call _ExitProcess@4

_main ENDP

END