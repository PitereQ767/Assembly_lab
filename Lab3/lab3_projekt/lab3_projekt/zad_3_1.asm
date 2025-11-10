.686
.model flat

extern __write:PROC, _ExitProcess@4:PROC

public _main


.data
	znaki db 12 dup (?)

.code
_wyswietl PROC
	pusha
	mov ebx, 10
	mov esi, 10

konwersja:
	mov edx, 0
	div ebx

	add dl, 30h
	mov znaki[esi], dl
	dec esi
	cmp eax, 0
	jne konwersja

wypeln:
	or esi, esi
	jz wyswietl
	mov byte PTR znaki[esi], 20h
	dec esi
	jmp wypeln

wyswietl:
	mov byte PTR znaki[0], 0ah
	mov byte PTR znaki[11], 0ah

	push 12
	push offset znaki
	push 1
	call __write
	add esp, 12

	popa

	ret
_wyswietl ENDP


_main PROC
	mov ecx, 50
	mov eax, 1
	mov ebx, 1

petla:
	call _wyswietl
	add eax, ebx
	add ebx, 1
	sub ecx, 1
	cmp ecx, 0
	jne petla

	push 0
	call _ExitProcess@4

_main ENDP

END